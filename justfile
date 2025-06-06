# Settings

set unstable := true
set windows-shell := ['C:\Program Files\PowerShell\7\pwsh.exe']

# Recipes
_default:
    @just --list

# Displays just summary
_ls:
    @just --summary

# Displays just version
version:
    @just --version
    @bazel version

# Displays bazel info
bazel-info:
    bazel info

# Lists bazel targets
list *filter="...":
    #!/usr/bin/env bash
    if [ "{{ filter }}" != "..." ]; then
      printf "\n=== Targets containing '%s' ===\n" "{{ filter }}"
      # Search for targets containing the filter string
      bazel query '//...' | grep -i "{{ filter }}" || printf "No targets containing %s\n" "{{ filter }}"
    else
      # Default behavior for '...'
      printf "=== All targets ===\n"
      bazel query {{ filter }}

      printf "\n=== All packages ===\n"
      bazel query 'kind(package, //...)' --output package
    fi

# Validates just & bazel files without making changes
lint:
    just --fmt --check
    buildifier --lint=warn -r .

# Formats & fixes lints in just & bazel files
format:
    just --fmt
    buildifier --lint=fix -r .
    bazel mod tidy

# Displays the direct dependencies of the target module(s).
deps:
    bazel mod graph

# Updates module dependencies in MODULE.bazel.lock lockfile
update:
    bazel mod deps --lockfile_mode=update

# Vendor dependencies
vendor:
    bazel vendor

# Cleans bazel build
clean:
    bazel clean --expunge

fetch target=("..."):
    bazel fetch {{ target }}

# Builds a bazel target
build target=("..."):
    bazel build {{ target }}

# Tests a bazel target
test target=("..."):
    bazel test {{ target }}

# Runs a bazel target
run target=("..."):
    bazel run {{ target }}

# Runs a hello client and server
hello:
    bazel run java/hello
    @echo
    bazel run go/hello
