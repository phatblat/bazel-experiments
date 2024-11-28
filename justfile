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

run:
    bazel run //java:HelloWorld
