const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = std.zig.CrossTarget{
        .os_tag = .freestanding,
        .cpu_arch = .riscv64,
        .abi = .none,
    };

    const kernel_linker = "src/kernel/kernel.ld";

    const kernel = b.addExecutable("kernel", "src/kernel/entry.zig");
    kernel.addAssemblyFile("src/kernel/trampoline.S");
    kernel.setLinkerScriptPath(.{ .path = kernel_linker });
    kernel.code_model = .medium;
    kernel.setTarget(target);
    kernel.setBuildMode(std.builtin.Mode.ReleaseSmall);
    kernel.install();
    kernel.strip = true;
}
