# https://bazel.build/rules/rules-tutorial
def _foo_binary_impl(ctx):
    print("analyzing", ctx.label)
    out = ctx.actions.declare_file(ctx.label.name)
    ctx.actions.write(
        output = out,
        content = "Hello\n",
    )
    return [DefaultInfo(files = depset([out]))]

foo_binary = rule(
    implementation = _foo_binary_impl,
)

print("bzl file evaluation")
