const c = @cImport({
    @cInclude("kernel/types.h");
    @cInclude("kernel/param.h");
    @cInclude("kernel/spinlock.h");
    @cInclude("kernel/sleeplock.h");
    @cInclude("kernel/fs.h");
    @cInclude("kernel/file.h");
    @cInclude("kernel/memlayout.h");
    @cInclude("kernel/riscv.h");
    @cInclude("kernel/defs.h");
    @cInclude("kernel/proc.h");
});
const std = @import("std");
const bufPrint = std.fmt.bufPrint;
const SpinLock = @import("SpinLock.zig");

const Printf = @This();

lock: SpinLock,
locking: bool,

pub fn init() Printf {
    return Printf{
        .lock = SpinLock{},
        .locking = true,
    };
}

pub fn print(self: *Printf, comptime fmt: []const u8, args: anytype) void {
    var locking = self.locking;
    if (locking) {
        self.lock.acquire();
    }

    var buf: [1024]u8 = undefined;
    const slice = bufPrint(&buf, fmt, args) catch unreachable;
    for (slice) |char| {
        c.consputc(char);
    }

    if (locking) {
        self.lock.release();
    }
}
