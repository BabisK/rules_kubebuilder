""" Dependencies for controller-gen
"""

load("@bazel_gazelle//:deps.bzl", "go_repository")
load("//controller-gen:controller-gen-external.bzl", "controller_gen_external")
load("//controller-gen:controller-gen-repository.bzl", "controller_gen_repository")
load("//controller-gen:controller-gen-toolchain.bzl", "controller_gen_toolchain")

def controller_gen_register_toolchains(version = None, controller_gen_binary = None):
    if (version == None and controller_gen_binary == None) or (version != None and controller_gen_binary != None):
        fail("Either version or controller_gen_binary must be set")

    repository_name = None

    if version != None:
        repository_name = "controller-gen_%s" % version.replace(".", "_")
        controller_gen_repository(
            name = repository_name,
            version = version,
        )
    else:
        repository_name = "controller-gen_source"
        controller_gen_external(
            name = repository_name,
            controller_gen_bin = controller_gen_binary,
        )

    native.register_toolchains("@%s//:controller_gen_toolchain_impl" % repository_name)
