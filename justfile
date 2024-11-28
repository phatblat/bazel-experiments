_default:
    @just --list

_ls:
    @just --summary

targets:
    bazel query ...

clean:
    bazel clean

build:
    bazel build ...

test:
    bazel test ...
