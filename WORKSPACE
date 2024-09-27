workspace(name = "rules_kubebuilder")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@rules_kubebuilder//kubebuilder:sdk.bzl", "kubebuilder_register_sdk")

kubebuilder_register_sdk(version = "2.3.1")

## Next section is for testing in this same MP.

http_archive(
    name = "rules_pkg",
    sha256 = "335632735e625d408870ec3e361e192e99ef7462315caa887417f4d88c4c8fb8",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.9.0/rules_pkg-0.9.0.tar.gz",
        "https://github.com/bazelbuild/rules_pkg/releases/download/0.9.0/rules_pkg-0.9.0.tar.gz",
    ],
)

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "af47f30e9cbd70ae34e49866e201b3f77069abb111183f2c0297e7e74ba6bbc0",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.47.0/rules_go-v0.47.0.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.47.0/rules_go-v0.47.0.zip",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.19.3")

load("@rules_kubebuilder//kustomize:deps.bzl", "kustomize_register_toolchain")

# 4.2.0 is the first version that supports the M1 architecture.
kustomize_register_toolchain(version = "4.2.0")

http_archive(
    name = "bazel_skylib",
    sha256 = "bc283cdfcd526a52c3201279cda4bc298652efa898b10b4db0837dc51652756f",
    urls = ["https://github.com/bazelbuild/bazel-skylib/releases/download/1.7.1/bazel-skylib-1.7.1.tar.gz"],
)
