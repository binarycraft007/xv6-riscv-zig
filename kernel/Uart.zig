const memlayout = @import("memlayout.zig");
const SpinLock = @import("SpinLock.zig");
const Proc = @import("Proc.zig");

/// the UART control registers.
/// some have different meanings for
/// read vs write.
/// see http://byterunner.com/16550.html
pub const RHR = 0; // receive holding register (for input bytes)
pub const THR = 0; // transmit holding register (for output bytes)
pub const IER = 1; // interrupt enable register
pub const IER_RX_ENABLE = 1 << 0;
pub const IER_TX_ENABLE = 1 << 1;
pub const FCR = 2; // FIFO control register
pub const FCR_FIFO_ENABLE = 1 << 0;
pub const FCR_FIFO_CLEAR = 3 << 1; // clear the content of the two FIFOs
pub const ISR = 2; // interrupt status register
pub const LCR = 3; // line control register
pub const LCR_EIGHT_BITS = 3 << 0;
pub const LCR_BAUD_LATCH = 1 << 7; // special mode to set baud rate
pub const LSR = 5; // line status register
pub const LSR_RX_READY = 1 << 0; // input is waiting to be read from RHR
pub const LSR_TX_IDLE = 1 << 5; // THR can accept another character to send

pub const TX_BUF_SIZE = 32;

tx_lock: SpinLock,
tx_buf: [TX_BUF_SIZE]u8,
tx_w: u64, // write next to uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE]
tx_r: u64, // read next from uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE]

const Uart = @This();
const panicked = false;

pub const Error = error{NotReady};

pub fn init() Uart {
    // disable interrupts.
    writeReg(IER, 0x00);

    // special mode to set baud rate.
    writeReg(LCR, LCR_BAUD_LATCH);

    // LSB for baud rate of 38.4K.
    writeReg(0, 0x03);

    // MSB for baud rate of 38.4K.
    writeReg(1, 0x00);

    // leave set-baud mode,
    // and set word length to 8 bits, no parity.
    writeReg(LCR, LCR_EIGHT_BITS);

    // reset and enable FIFOs.
    writeReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);

    // enable transmit and receive interrupts.
    writeReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);

    return Uart{
        .tx_w = 0,
        .tx_r = 0,
        .tx_buf = [_]u8{0} ** TX_BUF_SIZE,
        .tx_lock = SpinLock.init(),
    };
}

// add a character to the output buffer and tell the
// UART to start sending if it isn't already.
// blocks if the output buffer is full.
// because it may block, it can't be called
// from interrupts; it's only suitable for use
// by write().
pub fn putc(self: *Uart, c: u8) void {
    self.tx_lock.acquire();
    defer self.tx_lock.release();

    if (panicked) {
        while (true) {}
    }

    while (self.tx_w == self.tx_r + TX_BUF_SIZE) {
        // buffer is full.
        // wait for uartstart() to open up space in the buffer.
        Proc.sleep(&self.tx_r, &self.tx_lock);
    }
    self.tx_buf[self.tx_w % TX_BUF_SIZE] = c;
    self.tx_w += 1;
    self.start();
}

// alternate version of putc() that doesn't
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
pub fn putcSync(self: *Uart, c: u8) void {
    _ = self;
    SpinLock.pushOff();

    if (panicked) {
        while (true) {}
    }

    // wait for Transmit Holding Empty to be set in LSR.
    while ((readReg(LSR) & LSR_TX_IDLE) == 0) {}
    writeReg(THR, c);

    SpinLock.popOff();
}

/// if the UART is idle, and a character is waiting
/// in the transmit buffer, send it.
/// caller must hold uart_tx_lock.
/// called from both the top- and bottom-half.
pub fn start(self: *Uart) void {
    while (true) {
        if (self.tx_w == self.tx_r) {
            // transmit buffer is empty.
            return;
        }

        if ((readReg(LSR) & LSR_TX_IDLE) == 0) {
            // the UART transmit holding register is full,
            // so we cannot give it another byte.
            // it will interrupt when it's ready for a new byte.
            return;
        }

        var c = self.tx_buf[self.tx_r % TX_BUF_SIZE];
        self.tx_r += 1;

        // maybe uartputc() is waiting for space in the buffer.
        Proc.wakeup(&self.tx_r);

        writeReg(THR, c);
    }
}

/// read one input character from the UART.
/// return NotReady if none is waiting.
pub fn getc(self: *Uart) !void {
    _ = self;
    if (readReg(LSR) & 0x01) {
        // input data is ready.
        return readReg(RHR);
    } else {
        return error.NotReady;
    }
}

fn getRegAddr(reg: usize) *usize {
    return @intToPtr(*usize, memlayout.UART0 + reg);
}

pub fn readReg(reg: usize) usize {
    return getRegAddr(reg).*;
}

pub fn writeReg(reg: usize, value: usize) void {
    getRegAddr(reg).* = value;
}
