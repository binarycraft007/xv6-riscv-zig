/// qemu -kernel loads the kernel at 0x80000000
/// and causes each hart (i.e. CPU) to jump there.
/// kernel.ld causes the following code to
/// be placed at 0x80000000.
const start = @import("start.zig").start;
const param = @import("param.zig");

const stack_size: usize = 4096 * param.NCPU;
export fn _entry() callconv(.Naked) noreturn {
    // set up a stack for zig.
    // 4096-byte stack per CPU.
    // sp = stack0 + (hartid * 4096)
    const stack0 align(16) = [_]u8{0} ** stack_size;
    asm volatile (""
        :
        : [stack0] "{sp}" (stack0),
    );
    asm volatile (
        \\li a0, 1024*4
        \\csrr a1, mhartid
        \\addi a1, a1, 1
        \\mul a0, a0, a1
        \\add sp, sp, a0
    );
    // jump to start() in start.zig
    start();
    while (true) {}
}
