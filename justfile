set unstable := true

_default:
    @just --list

_ls:
    @just --summary

targets:
    bazel query ...

clean:
    bazel clean

format:
    just --fmt
    buildifier -r .

build v=("--noverbose_failures"):
    bazel build {{ v }} ...

test:
    bazel test ...

hello:
    bazel run java/hello
    @echo
    bazel run go/hello
