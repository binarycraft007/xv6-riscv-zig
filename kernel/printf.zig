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
const console = @import("console.zig");
pub export var panicked: bool = false;

var lock = SpinLock{};
pub var locking: bool = true;

pub fn print(comptime fmt: []const u8, args: anytype) void {
    const need_locking = locking;
    if (need_locking) lock.acquire();

    var buf: [1024]u8 = undefined;
    const slice = bufPrint(&buf, fmt, args) catch |err| {
        @panic(@errorName(err));
    };
    for (slice) |char| console.putc(char);

    if (need_locking) lock.release();
}

export fn panic(s: [*:0]u8) noreturn {
    locking = false;
    print("panic: {s}\n", .{s});
    panicked = true; // freeze uart output from other CPUs
    while (true) {}
}
