const param = @import("param.zig");
const riscv = @import("riscv.zig");
const Cpu = @import("Cpu.zig");
const SpinLock = @import("SpinLock.zig");

pub var cpus: [param.NCPU]Cpu = undefined;

pub const TrapFrame = struct {
    kernel_satp: u64,
    kernel_sp: u64,
    kernel_trap: u64,
    epc: u64,
    kernel_hartid: u64,
    ra: u64,
    sp: u64,
    gp: u64,
    tp: u64,
    t0: u64,
    t1: u64,
    t2: u64,
    s0: u64,
    s1: u64,
    a0: u64,
    a1: u64,
    a2: u64,
    a3: u64,
    a4: u64,
    a5: u64,
    a6: u64,
    a7: u64,
    s2: u64,
    s3: u64,
    s4: u64,
    s5: u64,
    s6: u64,
    s7: u64,
    s8: u64,
    s9: u64,
    s10: u64,
    s11: u64,
    t3: u64,
    t4: u64,
    t5: u64,
    t6: u64,
};

pub const ProcState = enum {
    UNUSED,
    USED,
    SLEEPING,
    RUNNABLE,
    RUNNING,
    ZOMBIE,
};

const Proc = @This();

lock: SpinLock,
state: ProcState,
chan: ?anyopaque,
killed: bool,
xstate: i32,
pid: i32,
parent: *Proc,

kstack: u64,
size: u64,
pagetable: riscv.PageTable,
trapframe: *TrapFrame,
context: Cpu.Context,

pub fn cpuId() u32 {
    return @intCast(u32, riscv.r_tp());
}

pub fn MyCpu() *Cpu {
    return &cpus[cpuId()];
}
