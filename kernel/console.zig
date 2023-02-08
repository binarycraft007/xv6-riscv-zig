const std = @import("std");
const ascii = std.ascii;
const Proc = @import("Proc.zig");
const uart = @import("uart.zig");
const SpinLock = @import("SpinLock.zig");

const BUF_SIZE = 128;
const BACKSPACE = 0x100;

var lock: SpinLock = SpinLock{};

// input
var buf: [BUF_SIZE]u8 = undefined;
var read_idx: u32 = 0; // Read index
var write_idx: u32 = 0; // Write index
var edit_idx: u32 = 0; // Edit index

pub fn init() void {
    uart.init();

    // ToDo: implemente console.read, console.write
    // connect read and write system calls
    // to consoleread and consolewrite.
    //devsw[CONSOLE].read = cons.read;
    //devsw[CONSOLE].write = cons.write;
}

/// send one character to the uart.
/// called by printf(), and to echo input characters,
/// but not from write().
pub fn putc(char: u8) void {
    if (char == BACKSPACE) {
        // if the user typed backspace, overwrite with a space.
        uart.putcSync(ascii.control_code.bs);
        uart.putcSync(' ');
        uart.putcSync(ascii.control_code.bs);
    } else {
        uart.putcSync(char);
    }
}

/// the console input interrupt handler.
/// uartintr() calls this for input character.
/// do erase/kill processing, append to cons.buf,
/// wake up consoleread() if a whole line has arrived.
pub fn intr(char: u8) void {
    lock.acquire();

    switch (char) {
        'P' => Proc.dump(),
        'U' => // Kill line.
        while (edit_idx != write_idx and
            buf[(edit_idx - 1) % BUF_SIZE] != '\n')
        {
            edit_idx -= 1;
            putc(BACKSPACE);
        },
        'H', '\x7f' => {
            if (edit_idx != write_idx) {
                edit_idx -= 1;
                putc(BACKSPACE);
            }
        },
        else => if (char != 0 and edit_idx - read_idx < BUF_SIZE) {
            char = if (char == '\r') '\n' else char;

            // echo back to the user.
            putc(char);

            // store for consumption by consoleread().
            buf[edit_idx % BUF_SIZE] = char;
            edit_idx += 1;

            if (char == '\n' or char == controlCode('D') or
                edit_idx - read_idx == BUF_SIZE)
            {
                // wake up consoleread() if a whole line (or end-of-file)
                // has arrived.
                write_idx = edit_idx;
                Proc.wakeup(&read_idx);
            }
        },
    }
    lock.release();
}

fn controlCode(char: u8) u8 {
    return char - '@';
}
