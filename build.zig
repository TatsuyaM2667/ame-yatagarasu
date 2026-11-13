// ame-shell(https://github.com/TatsuyaM2667/ame-shell)の src/cmd/ame-yatagarasu.zig から生成。直すときは ame-shell の方を直す
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const lib = b.createModule(.{ .root_source_file = b.path("src/lib/lib.zig") });

    const exe = b.addExecutable(.{ .name = "ame-yatagarasu", .root_source_file = b.path("src/main.zig"), .target = target, .optimize = optimize });
    exe.root_module.addImport("ame_lib", lib);
    exe.linkLibC();
    exe.linkSystemLibrary("ssl");
    exe.linkSystemLibrary("crypto");
    b.installArtifact(exe);

    const run = b.addRunArtifact(exe);
    if (b.args) |a| run.addArgs(a);
    b.step("run", "ame-yatagarasu を実行する").dependOn(&run.step);

    const t_main = b.addTest(.{ .root_source_file = b.path("src/main.zig"), .target = target, .optimize = optimize });
    t_main.root_module.addImport("ame_lib", lib);
    t_main.linkLibC();
    t_main.linkSystemLibrary("ssl");
    t_main.linkSystemLibrary("crypto");
    const t_lib = b.addTest(.{ .root_source_file = b.path("src/lib/lib.zig"), .target = target, .optimize = optimize });
    t_lib.linkLibC();
    const ts = b.step("test", "テスト");
    ts.dependOn(&b.addRunArtifact(t_main).step);
    ts.dependOn(&b.addRunArtifact(t_lib).step);
}
