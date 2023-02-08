const std = @import("std");
const riscv = @import("riscv.zig");
const memlayout = @import("memlayout.zig");
const SpinLock = @import("SpinLock.zig");
const print = @import("printf.zig").print;
const SinglyLinkedList = std.SinglyLinkedList;
const mem = std.mem;

extern var end: u8;

var lock = SpinLock{};
var free_list = SinglyLinkedList(usize){};

pub fn init() void {
    var start = riscv.PGROUNDUP(@ptrToInt(&end));
    std.debug.assert(start % 4096 == 0);
    print(
        "KernelHeap: available physical memory [0x{x}, 0x{x}]\n",
        .{ start, memlayout.PHYSTOP },
    );
    var pages = @intToPtr([*]u32768, start);
    freePages(pages[0..((memlayout.PHYSTOP - start) / 4096)]);
    print("KernelHeap: init memory done\n", .{});
}

pub fn freePages(pages: []u32768) void {
    for (pages) |*page| {
        free(@intToPtr([*]u8, @ptrToInt(page))[0..riscv.PGSIZE]);
    }
}

pub fn free(page: []u8) void {
    const addr = @ptrToInt(&page[0]);

    if ((addr % riscv.PGSIZE) != 0) @panic("not PGSIZE aligned");
    if (addr < @ptrToInt(&end)) @panic("forbit to free kernel mem");
    if (addr >= memlayout.PHYSTOP) @panic("invalid addr to free");

    mem.set(u8, page, 1); // Fill with junk to catch dangling refs.

    var free_mem = SinglyLinkedList(usize).Node{ .data = addr };
    lock.acquire();
    free_list.prepend(&free_mem);
    lock.release();
}
