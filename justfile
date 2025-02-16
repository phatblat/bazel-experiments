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

targets:
    bazel query ...

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
