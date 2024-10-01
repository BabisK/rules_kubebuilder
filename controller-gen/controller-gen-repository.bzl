def _controller_gen_repository_impl(ctx):
    version = ctx.attr.version

    os_map = {
        "linux": "linux",
        "macos": "darwin",
        "windows": "windows",
    }
    arch_map = {
        "amd64": "amd64",
        "x86_64": "amd64",
        "arm64": "arm64",
    }

    map_os = {
        "linux": "linux",
        "darwin": "macos",
        "windows": "windows",
    }

    map_arch = {
        "x86_64": "x86_64",
        "amd64": "x86_64",
        "arm64": "arm64",
    }

    os_name = ctx.os.name
    arch_name = ctx.os.arch
    print("Downloading controller-gen for %s-%s" % (os_name, arch_name))

    if os_name not in os_map:
        fail("Unsupported OS: %s" % os_name)
    if arch_name not in arch_map:
        fail("Unsupported architecture: %s" % arch_name)

    release_os = os_map[os_name]
    release_arch = arch_map[arch_name]

    url = "https://github.com/kubernetes-sigs/controller-tools/releases/download/v{version}/controller-gen-{os}-{arch}{suffix}".format(
        version = version,
        os = release_os,
        arch = release_arch,
        suffix = ".exe" if os_name == "windows" else "",
    )

    controller_gen_bin = ctx.download(
        url = url,
        output = "controller-gen",
        executable = True,
    )

    ctx.file("BUILD.bazel", """
package(default_visibility = ["//visibility:public"])

exports_files(["controller-gen"])

load("@rules_kubebuilder//controller-gen:controller-gen-toolchain.bzl", "controller_gen_toolchain")

controller_gen_toolchain(
    name = "controller_gen_toolchain",
    controller_gen_bin = ":controller-gen",
)

toolchain(
    name = "controller_gen_toolchain_impl",
    toolchain_type = "@rules_kubebuilder//controller-gen:toolchain",
    toolchain = ":controller_gen_toolchain",
    exec_compatible_with = [
        "@platforms//os:{os}",
        "@platforms//cpu:{arch}",
    ],
)
""".format(os = map_os[os_name], arch = map_arch[arch_name]))

controller_gen_repository = repository_rule(
    implementation = _controller_gen_repository_impl,
    attrs = {
        "version": attr.string(mandatory = True),
    },
    local = False,
)
