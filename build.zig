const std = @import("std");
const LazyPath = std.Build.LazyPath;

pub const BuildConfig = struct {
    zero_memory: ?bool = null,
    debug: ?bool = null,
    min_stack_size: ?usize = null,
    default_storage_size: ?usize = null,
    default_stack_size: ?usize = null,
};

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    // todo: how to do this?
    var opts = BuildConfig{};
    inline for (std.meta.fields(BuildConfig)) |field| {
        @field(opts, field.name) = b.option(@typeInfo(field.type).Optional.child, "mco_" ++ field.name, "");
    }

    const mod = b.addModule("minicoro", .{
        .source_file = .{ .path = "src/lib.zig" },
    });
    _ = mod;

    const lib = b.addStaticLibrary(.{
        .name = "minicoro",
        .root_source_file = null,
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibC();
    if (opts.zero_memory) |x| lib.defineCMacro("MCO_ZERO_MEMORY", if (x) "1" else "0");
    if (opts.debug) |x| lib.defineCMacro("MCO_DEBUG", if (x) "1" else "0");
    if (opts.min_stack_size) |x| lib.defineCMacro("MCO_MIN_STACK_SIZE", b.fmt("{}", .{x}));
    if (opts.default_stack_size) |x| lib.defineCMacro("MCO_DEFAULT_STACK_SIZE", b.fmt("{}", .{x}));
    if (opts.default_storage_size) |x| lib.defineCMacro("MCO_DEFAULT_STORAGE_SIZE", b.fmt("{}", .{x}));
    lib.addCSourceFile(.{ .file = LazyPath.relative("src/minicoro.c"), .flags = &.{} });
    b.installArtifact(lib);

    // Creates a step for unit testing.
    const main_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/lib.zig" },
        .target = target,
        .optimize = optimize,
    });
    main_tests.linkLibrary(lib);
    main_tests.addIncludePath(LazyPath.relative("src"));

    // This creates a build step. It will be visible in the `zig build --help` menu,
    // and can be selected like this: `zig build test`
    // This will evaluate the `test` step rather than the default, which is "install".
    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
