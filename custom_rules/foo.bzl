# https://bazel.build/rules/rules-tutorial
def _foo_binary_impl(ctx):
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
