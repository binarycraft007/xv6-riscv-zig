const std = @import("std");
const fmt = std.fmt;
const SpinLock = @import("SpinLock.zig");
const console = @import("console.zig");

/// The errors that can occur when logging
const LoggingError = error{};

/// The Writer for the format function
const Writer = std.io.Writer(void, LoggingError, logCallback);

var lock: SpinLock = SpinLock{};
pub var locking: bool = true;
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
    print(prefix ++ format, args);

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

pub fn print(comptime format: []const u8, args: anytype) void {
    fmt.format(Writer{ .context = {} }, format, args) catch unreachable;
}

pub export fn printf(format: [*:0]const u8, ...) void {
    var need_lock = locking;
    if (need_lock) lock.acquire();

    if (std.mem.span(format).len == 0) @panic("null fmt");

    var ap = @cVaStart();
    for (std.mem.span(format)) |byte, i| {
        if (byte != '%') {
            console.writeByte(byte);
            continue;
        }
        var c = format[i + 1] & 0xff;
        if (c == 0) break;
        switch (c) {
            'd' => print("{d}", .{@cVaArg(&ap, c_int)}),
            'x' => print("{x}", .{@cVaArg(&ap, c_int)}),
            'p' => print("{p}", .{@cVaArg(&ap, *usize)}),
            's' => {
                var s = std.mem.span(@cVaArg(&ap, [*:0]const u8));
                console.writeBytes(s);
            },
            '%' => console.writeByte('%'),
            else => {
                // Print unknown % sequence to draw attention.
                console.writeByte('%');
                console.writeByte(c);
            },
        }
    }
    @cVaEnd(&ap);

    if (need_lock) lock.release();
}
