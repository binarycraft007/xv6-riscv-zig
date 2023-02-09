const std = @import("std");
const riscv = @import("riscv.zig");
const memlayout = @import("memlayout.zig");
const SpinLock = @import("SpinLock.zig");
const print = @import("printf.zig").print;
const TailQueue = std.TailQueue;
const kalloc_log = std.log.scoped(.kalloc);
const mem = std.mem;

extern var end: u8;

var lock = SpinLock{};
var free_list = TailQueue([]u8){};

pub fn init() void {
    var start = riscv.PGROUNDUP(@ptrToInt(&end));
    std.debug.assert(start % 4096 == 0);
    kalloc_log.info(
        "available physical memory [0x{x}, 0x{x}]\n",
        .{ start, memlayout.PHYSTOP },
    );
    var pages = @intToPtr([*]u32768, start);
    freePages(pages[0..((memlayout.PHYSTOP - start) / 4096)]);
    kalloc_log.info("init memory done\n", .{});
}

pub fn freePages(pages: []u32768) void {
    for (pages) |*page| free(mem.asBytes(page));
}

/// Free the page of physical memory pointed at by start,
/// which normally should have been returned by a
/// call to kalloc().  (The exception is when
/// initializing the allocator; see kinit above.)
pub fn free(page: []u8) void {
    std.debug.assert(page.len == riscv.PGSIZE);

    const addr = @ptrToInt(&page[0]);

    if ((addr % riscv.PGSIZE) != 0) @panic("not PGSIZE aligned");
    if (addr < @ptrToInt(&end)) @panic("forbit to free kernel mem");
    if (addr >= memlayout.PHYSTOP) @panic("invalid addr to free");

    mem.set(u8, page, 1); // Fill with junk to catch dangling refs.

    var free_mem = TailQueue([]u8).Node{ .data = page };
    lock.acquire();
    free_list.append(&free_mem);
    lock.release();
}

/// Allocate one 4096-byte page of physical memory.
/// Returns a pointer that the kernel can use.
/// Returns error if the memory cannot be allocated.
pub fn alloc() ![]u8 {
    lock.acquire();
    var list_old = free_list;
    if (list_old.first) |node| list_old.remove(node);
    lock.release();

    if (list_old.first) |node| {
        mem.set(u8, node.data, 5);
        return node.data;
    }
    return error.KallocFailed;
}
