# Settings

set unstable := true
set windows-shell := ['C:\Program Files\PowerShell\7\pwsh.exe']

# Recipes
_default:
    @just --list

_ls:
    @just --summary

format:
    just --fmt
    buildifier -r .
    bazel mod tidy

targets:
    bazel query ...

# Updates module dependencies in MODULE.bazel.lock lockfile
update:
    bazel mod deps --lockfile_mode=update

clean:
    bazel clean

build target=("..."):
    bazel build {{ target }}

test target=("..."):
    bazel test {{ target }}

run target=("..."):
    bazel run {{ target }}

hello:
    bazel run java/hello
    @echo
    bazel run go/hello
