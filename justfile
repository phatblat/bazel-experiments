_default:
    @just --list

_ls:
    @just --summary

targets:
    bazel query ...

build:
    bazel build ...

test:
    bazel test ...
