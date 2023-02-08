const std = @import("std");
const ascii = std.ascii;
const Proc = @import("Proc.zig");
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
        .lock = SpinLock{},
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

/// send one character to the uart.
/// called by printf(), and to echo input characters,
/// but not from write().
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

/// the console input interrupt handler.
/// uartintr() calls this for input character.
/// do erase/kill processing, append to cons.buf,
/// wake up consoleread() if a whole line has arrived.
pub fn intr(self: Console, c: u8) void {
    self.lock.acquire();
    defer self.lock.release();

    switch (c) {
        'P' => Proc.dump(),
        'U' => // Kill line.
        while (self.edit_idx != self.write_idx and
            self.buf[(self.edit_idx - 1) % BUF_SIZE] != '\n')
        {
            self.edit_idx -= 1;
            self.putc(BACKSPACE);
        },
        'H', '\x7f' => {
            if (self.edit_idx != self.write_idx) {
                self.edit_idx -= 1;
                self.putc(BACKSPACE);
            }
        },
        else => if (c != 0 and self.edit_idx - self.read_idx < BUF_SIZE) {
            c = if (c == '\r') '\n' else c;

            // echo back to the user.
            self.putc(c);

            // store for consumption by consoleread().
            self.buf[self.edit_idx % BUF_SIZE] = c;
            self.edit_idx += 1;

            if (c == '\n' or c == controlCode('D') or
                self.edit_idx - self.read_idx == BUF_SIZE)
            {
                // wake up consoleread() if a whole line (or end-of-file)
                // has arrived.
                self.write_idx = self.edit_idx;
                Proc.wakeup(&self.read_idx);
            }
        },
    }
}

/// handle a uart interrupt, raised because input has
/// arrived, or the uart is ready for more output, or
/// both. called from devintr().
pub fn uartIntr(self: *Console) !void {
    // read and process incoming characters.
    while (true) {
        var c = self.uart.getc() catch break;
        self.intr(c);
    }

    // send buffered characters.
    self.uart.tx_lock.acquire();
    self.uart.start();
    self.uart.tx_lock.release();
}

fn controlCode(c: u8) u8 {
    return c - '@';
}
