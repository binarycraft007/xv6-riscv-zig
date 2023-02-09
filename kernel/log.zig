const std = @import("std");
const fmt = std.fmt;
const SpinLock = @import("SpinLock.zig");
const console = @import("console.zig");

/// The errors that can occur when logging
const LoggingError = error{};

/// The Writer for the format function
const Writer = std.io.Writer(void, LoggingError, logCallback);

var lock: SpinLock = SpinLock{};
pub var locking: bool = false;
pub export var panicked: bool = false;

fn logCallback(context: void, str: []const u8) LoggingError!usize {
    // Suppress unused var warning
    _ = context;
    console.writeBytes(str);
    return str.len;
}

pub fn klogFn(
    comptime level: std.log.Level,
    comptime scope: @TypeOf(.EnumLiteral),
    comptime format: []const u8,
    args: anytype,
) void {
    const need_lock = locking;
    if (need_lock) lock.acquire();

    const scope_prefix = "(" ++ @tagName(scope) ++ "): ";

    const prefix = "[" ++ comptime level.asText() ++ "] " ++ scope_prefix;
    fmt.format(Writer{ .context = {} }, prefix ++ format, args) catch |err| {
        console.writeBytes(@errorName(err));
    };

    if (need_lock) lock.release();
}

export fn panic(s: [*:0]u8) noreturn {
    @setCold(true);
    const panic_log = std.log.scoped(.panic);
    locking = false;
    panic_log.err("{s}\n", .{s});
    panicked = true; // freeze uart output from other CPUs
    while (true) {}
}
