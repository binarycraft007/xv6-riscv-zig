const std = @import("std");
const mem = std.mem;
const kvm_log = std.log.scoped(.kvm);
const riscv = @import("riscv.zig");
const kalloc = @import("kalloc.zig");
const memlayout = @import("memlayout.zig");
const Proc = @import("Proc.zig");

extern var etext: u8;
extern var trampoline: u8;

var kernel_page: []usize = undefined;
extern var kernel_pagetable: [*]usize;

pub fn init() void {
    kvm_log.debug("start init kernel page table\n", .{});
    kernel_page = make() catch |err| @panic(@errorName(err));
    kernel_pagetable = kernel_page.ptr;
    kvm_log.debug("kernel page table init success\n", .{});
}

pub fn make() ![]usize {
    var kpgtbl_maybe = sliceToPageTable(try kalloc.allocPage());
    if (kpgtbl_maybe) |kpgtbl| {
        mem.set(u8, mem.sliceAsBytes(kpgtbl), 0);

        // uart registers
        try mapPages(
            kpgtbl,
            memlayout.UART0,
            riscv.PGSIZE,
            memlayout.UART0,
            riscv.PTE_R | riscv.PTE_W,
        );

        // virtio mmio disk interface
        try mapPages(
            kpgtbl,
            memlayout.VIRTIO0,
            riscv.PGSIZE,
            memlayout.VIRTIO0,
            riscv.PTE_R | riscv.PTE_W,
        );

        // PLIC
        try mapPages(
            kpgtbl,
            memlayout.PLIC,
            0x400000,
            memlayout.PLIC,
            riscv.PTE_R | riscv.PTE_W,
        );

        // map kernel text executable and read-only.
        try mapPages(
            kpgtbl,
            memlayout.KERNBASE,
            @ptrToInt(&etext) - memlayout.KERNBASE,
            memlayout.KERNBASE,
            riscv.PTE_R | riscv.PTE_X,
        );

        // map kernel data and the physical RAM we'll make use of.
        try mapPages(
            kpgtbl,
            @ptrToInt(&etext),
            memlayout.PHYSTOP - @ptrToInt(&etext),
            @ptrToInt(&etext),
            riscv.PTE_R | riscv.PTE_W,
        );

        // map the trampoline for trap entry/exit to
        // the highest virtual address in the kernel.
        try mapPages(
            kpgtbl,
            memlayout.TRAMPOLINE,
            riscv.PGSIZE,
            @ptrToInt(&trampoline),
            riscv.PTE_R | riscv.PTE_X,
        );

        try Proc.mapStacks(kpgtbl);
        return kpgtbl;
    }

    return error.FailedToInitKvm;
}

export fn kvmmake() [*]usize {
    var pagetable = make() catch |err| @panic(@errorName(err));
    return pagetable.ptr;
}

pub fn sliceToPageTable(page: []u8) ?[]usize {
    var kpgtbl = mem.alignInSlice(page, @alignOf([*]usize));
    if (kpgtbl) |slice| {
        var aligned_len = slice.len / @alignOf([*]usize);
        var new_slice = @ptrCast([*]usize, slice.ptr)[0..aligned_len];
        return new_slice;
    }
    return null;
}

/// Create PTEs for virtual addresses starting at va that refer to
/// physical addresses starting at pa. va and size might not
/// be page-aligned. Returns 0 on success, -1 if walk() couldn't
/// allocate a needed page-table page.
pub fn mapPages(page: []usize, va: usize, size: usize, pa: usize, perm: usize) !void {
    if (size == 0) return error.SizeCannotBeZero;

    var pa_var: usize = pa;
    var addr = mem.alignBackward(va, mem.page_size);
    var last = mem.alignBackward(va + size - 1, mem.page_size);

    while (true) : ({
        addr += riscv.PGSIZE;
        pa_var += riscv.PGSIZE;
    }) {
        var pte = try walk(page, addr, true);
        if ((pte.* & riscv.PTE_V) > 0) return error.ReMap;
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
pub fn walk(page: []usize, va: usize, alloc: bool) !*usize {
    var page_var = page;

    if (va >= riscv.MAXVA) return error.ExceedsMaxVA;

    var level: usize = 2;
    while (level > 0) : (level -= 1) {
        var pte = &page_var[riscv.PX(level, va)];
        if ((pte.* & riscv.PTE_V) > 0) {
            page_var.ptr = @intToPtr([*]usize, riscv.PTE2PA(pte.*));
        } else {
            if (!alloc) return error.PageWalkFailed;
            page_var = sliceToPageTable(try kalloc.allocPage()) orelse {
                return error.PageWalkFailed;
            };
            mem.set(u8, mem.sliceAsBytes(page_var), 0);
            pte.* = riscv.PA2PTE(@ptrToInt(&page_var[0])) | riscv.PTE_V;
        }
    }

    return &page_var[riscv.PX(0, va)];
}
