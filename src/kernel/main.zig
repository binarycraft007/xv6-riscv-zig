const Proc = @import("Proc.zig");
const Console = @import("Console.zig");

pub fn main() void {
    if (Proc.cpuId() == 0) {
        _ = Console.init();
    }
}
