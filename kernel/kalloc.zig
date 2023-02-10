const c = @cImport({
    @cInclude("kernel/types.h");
    @cInclude("kernel/param.h");
    @cInclude("kernel/memlayout.h");
    @cInclude("kernel/riscv.h");
    @cInclude("kernel/defs.h");
});
const std = @import("std");
const riscv = @import("riscv.zig");
const memlayout = @import("memlayout.zig");
const SpinLock = @import("SpinLock.zig");
const SinglyLinkedList = std.SinglyLinkedList;
const kalloc_log = std.log.scoped(.kalloc);
const mem = std.mem;

extern var end: [*]u8;

var lock = SpinLock{};
var free_list = SinglyLinkedList([]u8){};

pub fn init() void {
    var start = mem.alignForward(@ptrToInt(&end), mem.page_size);
    var ptr = @intToPtr([*]u8, start);
    kalloc_log.debug(
        "available [0x{x} - 0x{x}]\n",
        .{ start, memlayout.PHYSTOP },
    );
    freePages(ptr[0..(memlayout.PHYSTOP - start)]);
    kalloc_log.debug("init memory done\n", .{});
}

pub fn freePages(pages: []u8) void {
    var i: usize = 0;
    while ((i + 4096) <= pages.len) : (i += 4096) {
        freePage(@ptrCast([*]u8, &pages[i])[0..riscv.PGSIZE]);
    }
}

/// Free the page of physical memory pointed at by start,
/// which normally should have been returned by a
/// call to kalloc().  (The exception is when
/// initializing the allocator; see kinit above.)
pub fn freePage(page: []u8) void {
    const addr = @ptrToInt(&page[0]);

    if (!mem.isAligned(addr, riscv.PGSIZE)) @panic("not aligned");
    if (addr < @ptrToInt(&end)) @panic("forbit to free kernel mem");
    if (addr >= memlayout.PHYSTOP) @panic("invalid addr to free");

    mem.set(u8, page[0..riscv.PGSIZE], 1);

    lock.acquire();
    free_list.prepend(&SinglyLinkedList([]u8).Node{ .data = page });
    lock.release();
}

/// Allocate one 4096-byte page of physical memory.
/// Returns a pointer that the kernel can use.
/// Returns error if the memory cannot be allocated.
pub fn allocPage() ![]u8 {
    lock.acquire();
    var first_node = free_list.popFirst();
    lock.release();

    if (first_node) |node| {
        if (!mem.isAligned(@ptrToInt(&node.data[0]), riscv.PGSIZE)) {
            @panic("kalloc failed, memory os is not page aligned");
        }
        kalloc_log.debug("alloc page start: {p}\n", .{&node.data[0]});
        mem.set(u8, node.data[0..riscv.PGSIZE], 5);
        return node.data;
    }
    return error.KallocFailed;
}

/// wrapper for allocPage used by c code
pub export fn kalloc() ?*anyopaque {
    var slice = allocPage() catch return null;
    return slice.ptr;
}

/// wrapper for freePage used by c code
pub export fn kfree(pa: ?*anyopaque) void {
    var slice = @ptrCast([*]u8, pa)[0..riscv.PGSIZE];
    freePage(slice);
}
