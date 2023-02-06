const riscv = @import("riscv.zig");
const Proc = @import("Proc.zig");
const Cpu = @import("Cpu.zig");

// Mutual exclusion lock.
locked: bool, // Is the lock held?
// For debugging:
cpu: *Cpu, // The cpu holding the lock.

const SpinLock = @This();

pub fn init() SpinLock {
    return SpinLock{
        .locked = false,
        .cpu = undefined,
    };
}

pub fn acquire(self: *SpinLock) void {
    pushOff();

    if (holding(self))
        @panic("acquire");

    while (@atomicRmw(bool, &self.locked, .Xchg, true, .SeqCst)) {}

    self.cpu = Proc.MyCpu();
}

pub fn release(self: *SpinLock) void {
    if (!holding(self))
        @panic("release");
    self.cpu = undefined;

    @atomicRmw(bool, &self.locked, .Xchg, false, .SeqCst);
    popOff();
}

pub fn holding(self: *SpinLock) bool {
    return self.locked and self.cpu == Proc.MyCpu();
}

pub fn pushOff() void {
    var old = riscv.intr_get();

    riscv.intr_off();
    if (Proc.MyCpu().noff == 0)
        Proc.MyCpu.intena = old;
    Proc.MyCpu().noff += 1;
}

pub fn popOff() void {
    var cpu = Proc.MyCpu();
    if (riscv.intr_get() > 0)
        @panic("pop_off - interruptible");

    if (cpu.noff < 1)
        @panic("pop_off");

    cpu.noff -= 1;
    if (cpu.off == 0 and cpu.intena > 0)
        riscv.intr_on();
}
