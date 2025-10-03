#!/usr/bin/env bash

# This script is needed to be executed after the project installation.
# Run it manually if project was generated with locally installed cookiecutter.
# In case of the `create.sh` script usage, this file is not needed.

debug() {
  echo "⚙️ $@"
}

warn() {
  echo "⚠️ WARNING: $@" >&2
}

debug "Initializing the project and the toolset..."
make prepare

debug "Formatting the code..."
make fmt

debug "Building the app..."
make build
