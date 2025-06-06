"""Custom Bazel rule implementations for text and C++ generation.

This module defines two custom Bazel rules:

1. foo_binary: Creates a simple text file containing a greeting with
   a customizable username parameter.

2. hello_world: Generates a C++ source file from a template, substituting
   the provided username into the template.

Both rules demonstrate basic concepts of Bazel's rule creation system including
actions.write for direct content creation and actions.expand_template for
template-based file generation.

Reference: https://bazel.build/rules/rules-tutorial
"""
def _foo_binary_impl(ctx):
    # buildifier: disable=print
    print("analyzing", ctx.label)
    out = ctx.actions.declare_file(ctx.label.name)
    ctx.actions.write(
        output = out,
        content = "Hello {}!\n".format(ctx.attr.username),
    )
    return [DefaultInfo(files = depset([out]))]

foo_binary = rule(
    implementation = _foo_binary_impl,
    attrs = {
        "username": attr.string(),
    },
)

# buildifier: disable=print
print("bzl file evaluation")

def _hello_world_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name + ".cc")
    ctx.actions.expand_template(
        output = out,
        template = ctx.file.template,
        substitutions = {"{NAME}": ctx.attr.username},
    )
    return [DefaultInfo(files = depset([out]))]

hello_world = rule(
    implementation = _hello_world_impl,
    attrs = {
        "username": attr.string(default = "unknown person"),
        "template": attr.label(
            allow_single_file = [".cc.tpl"],
            mandatory = True,
        ),
        # private attribute
        # "_template": attr.label(
        #     allow_single_file = True,
        #     default = "file.cc.tpl",
        # ),
    },
)
