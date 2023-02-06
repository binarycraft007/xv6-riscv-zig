const std = @import("std");
const ascii = std.ascii;
const Uart = @import("Uart.zig");
const SpinLock = @import("SpinLock.zig");

const BUF_SIZE = 128;
const BACKSPACE = 0x100;
const Console = @This();

lock: SpinLock,

// input
buf: [BUF_SIZE]u8,
read_idx: u32, // Read index
write_idx: u32, // Write index
edit_idx: u32, // Edit index
uart: Uart,

pub fn init() Console {
    var cons = Console{
        .lock = SpinLock.init(),
        .buf = [_]u8{0} ** BUF_SIZE,
        .read_idx = 0,
        .write_idx = 0,
        .edit_idx = 0,
        .uart = Uart.init(),
    };

    // connect read and write system calls
    // to consoleread and consolewrite.
    //devsw[CONSOLE].read = cons.read;
    //devsw[CONSOLE].write = cons.write;

    return cons;
}

///
/// send one character to the uart.
/// called by printf(), and to echo input characters,
/// but not from write().
///
pub fn putc(self: *Console, c: u8) void {
    if (c == BACKSPACE) {
        // if the user typed backspace, overwrite with a space.
        self.uart.putcSync(ascii.control_code.bs);
        self.uart.putcSync(' ');
        self.uart.putcSync(ascii.control_code.bs);
    } else {
        self.uart.putcSync(c);
    }
}

fn controlCode(c: u8) u8 {
    return c - '@';
}
