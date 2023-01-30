const param = @import("param.zig");

// Saved registers for kernel context switches.
pub const Context = struct {
    ra: usize,
    sp: usize,

    // callee-saved
    s0: usize,
    s1: usize,
    s2: usize,
    s3: usize,
    s4: usize,
    s5: usize,
    s6: usize,
    s7: usize,
    s8: usize,
    s9: usize,
    s10: usize,
    s11: usize,
};

// Per-CPU state.
pub const Cpu = struct {
    //proc: *Proc, // The process running on this cpu, or null.
    context: Context, // swtch() here to enter scheduler().
    noff: i32, // Depth of push_off() nesting.
    intena: i32, // Were interrupts enabled before push_off()?
};

pub var cpus: [param.NCPU]Cpu = undefined;

pub const ProcState = enum {
    UNUSED,
    USED,
    SLEEPING,
    RUNNABLE,
    RUNNING,
    ZOMBIE,
};
