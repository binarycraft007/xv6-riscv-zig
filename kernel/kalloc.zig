const std = @import("std");
const riscv = @import("riscv.zig");
const memlayout = @import("memlayout.zig");
const SpinLock = @import("SpinLock.zig");
const print = @import("printf.zig").print;
const SinglyLinkedList = std.SinglyLinkedList;
const mem = std.mem;

extern var end: u8;

var kmem = .{
    .lock = SpinLock{},
    .free_list = SinglyLinkedList(usize){},
};

pub fn init() void {
    var start = riscv.PGROUNDUP(@ptrToInt(&end));
    std.debug.assert(start % 4096 == 0);
    print("start zig: {d}\n", .{@ptrToInt(&end)});
    var pages = @intToPtr([*]u32768, start);
    freePages(pages[0 .. (memlayout.PHYSTOP - start) / 32768]);
}

pub fn freePages(pages: []u32768) void {
    for (pages) |*page| {
        //freePage(page);
        var page_start = @intToPtr([*]u8, @ptrToInt(page));
        print("{any}\n", .{page_start[1]});
        //free(ptr);
    }
}

pub fn free(page: *u8) void {
    var slice = @intToPtr([*]u8, @ptrToInt(page));
    const addr = @ptrToInt(page);

    if ((addr & riscv.PGSIZE) != 0) @panic("free out of PGSIZE");
    if (addr < @ptrToInt(&end)) @panic("free out of end addr");
    if (addr >= memlayout.PHYSTOP) @panic("free mem beyoud PHYSTOP");

    mem.set(u8, slice[0..riscv.PGSIZE], 1);

    var free_mem = SinglyLinkedList(usize).Node{ .data = addr };
    kmem.lock.acquire();
    kmem.free_list.prepend(&free_mem);
    kmem.lock.release();
}
