load("@bazel_skylib//lib:unittest.bzl", "asserts", "unittest")

def test_crd_extra_attrs():
    load("@rules_kubebuilder//controller-gen:controller-gen.bzl", "_crd_extra_attrs")

    attrs = _crd_extra_attrs()

    # Test that attrs contain the expected keys
    asserts.true("trivialVersions" in attrs)
    asserts.equal(attrs["trivialVersions"].default, True)

def test_maybe_add_gopath_dep():
    load("@rules_kubebuilder//controller-gen:controller-gen.bzl", "_maybe_add_gopath_dep")

    kwargs = {"deps": ["//some:dep"]}
    _maybe_add_gopath_dep("test_rule", kwargs)
    asserts.true("gopath_dep" in kwargs)
    asserts.equal(kwargs["gopath_dep"], "test_rule_controller_gen")

unittest.register_test(test_crd_extra_attrs)
unittest.register_test(test_maybe_add_gopath_dep)
