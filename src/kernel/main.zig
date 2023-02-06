const Proc = @import("Proc.zig");
const Console = @import("Console.zig");

var started: bool = false;

pub fn main() void {
    if (Proc.cpuId() == 0) {
        _ = Console.init();
        @fence(.SeqCst);
        started = true;
    } else {
        while (started == false) {}
        @fence(.SeqCst);
    }
}
