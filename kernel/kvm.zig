const std = @import("std");
const mem = std.mem;
const kvm_log = std.log.scoped(.kvm);
const riscv = @import("riscv.zig");
const kalloc = @import("kalloc.zig");
const memlayout = @import("memlayout.zig");

extern var etext: u8;
extern var trampoline: u8;

var kernel_page: []u8 = undefined;

pub fn init() void {
    kvm_log.debug("start init kernel page table\n", .{});
    kernel_page = make() catch |err| @panic(@errorName(err));
    kvm_log.debug("kernel page table init success\n", .{});
}

pub fn make() ![]u8 {
    var kpgtbl = try kalloc.alloc();
    mem.set(u8, kpgtbl, 0);

    // uart registers
    mapPages(&kpgtbl, memlayout.UART0, riscv.PGSIZE, memlayout.UART0, riscv.PTE_R | riscv.PTE_W);

    return kpgtbl;
}

/// Create PTEs for virtual addresses starting at va that refer to
/// physical addresses starting at pa. va and size might not
/// be page-aligned. Returns 0 on success, -1 if walk() couldn't
/// allocate a needed page-table page.
pub fn mapPages(page: *[]u8, va: usize, size: usize, pa: usize, perm: usize) void {
    if (size == 0) @panic("mappages: size");

    var addr = riscv.PGROUNDDOWN(va);
    var last = riscv.PGROUNDDOWN(va + size - 1);
    var pa_var: usize = pa;

    while (true) : ({
        addr += riscv.PGSIZE;
        pa_var += riscv.PGSIZE;
    }) {
        var pte = walk(page, addr, true) catch @panic("mappages: get pte");
        if ((pte.* & riscv.PTE_V) > 0) @panic("mappages: remap");
        pte.* = riscv.PA2PTE(pa_var) | perm | riscv.PTE_V;
        if (addr == last) break;
    }
    return;
}

// Return the address of the PTE in page table pagetable
// that corresponds to virtual address va.  If alloc!=0,
// create any required page-table pages.
//
// The risc-v Sv39 scheme has three levels of page-table
// pages. A page-table page contains 512 64-bit PTEs.
// A 64-bit virtual address is split into five fields:
//   39..63 -- must be zero.
//   30..38 -- 9 bits of level-2 index.
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pub fn walk(page: *[]u8, va: usize, alloc: bool) !*usize {
    if (va >= riscv.MAXVA) @panic("walk");

    var level: usize = 2;
    while (level > 0) : (level -= 1) {
        var pte = @intToPtr(*usize, @ptrToInt(&page.*[riscv.PX(level, va)]));
        if ((pte.* & riscv.PTE_V) > 0) {
            page.*.ptr = @intToPtr([*]u8, riscv.PTE2PA(pte.*));
        } else {
            if (!alloc) return error.PageWalkFailed;
            page.* = try kalloc.alloc();
            mem.set(u8, page.*, 0);
            pte.* = riscv.PA2PTE(@ptrToInt(&page.*)) | riscv.PTE_V;
        }
    }
    return @intToPtr(*usize, @ptrToInt(&page.*[riscv.PX(0, va)]));
}
