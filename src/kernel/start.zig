const riscv = @import("riscv.zig");
const main = @import("main.zig");

// assembly code in kernelvec.S for machine-mode timer interrupt.
extern fn timervec() void;

// entry.zig jumps here in machine mode on stack0.
pub fn start() void {
    // set M Previous Privilege mode to Supervisor, for mret.
    var mstatus = riscv.r_mstatus();
    mstatus &= ~@as(usize, riscv.MSTATUS_MPP_MASK);
    mstatus |= @enumToInt(riscv.MSTATUS.MPP_S);
    riscv.w_mstatus(mstatus);

    // set M Exception Program Counter to main, for mret.
    // requires code_model = .medium
    riscv.w_mepc(@ptrToInt(&main.main));

    // disable paging for now.
    riscv.w_satp(0);

    // delegate all interrupts and exceptions to supervisor mode.
    riscv.w_medeleg(@as(usize, 0xffff));
    riscv.w_mideleg(@as(usize, 0xffff));
    riscv.w_sie(riscv.r_sie() |
        @enumToInt(riscv.SIE.SEIE) |
        @enumToInt(riscv.SIE.STIE) |
        @enumToInt(riscv.SIE.SSIE));

    // configure Physical Memory Protection to give supervisor mode
    // access to all of physical memory.
    riscv.w_pmpaddr0(@as(usize, 0x3fffffffffffff));
    riscv.w_pmpcfg0(@as(usize, 0xf));

    asm volatile ("mret");
}
