#!/bin/bash
set -euo pipefail

source "$1/buildByond.conf"

original_dir=$PWD
cd "$1"
wget -O ./librust_g.so "https://github.com/goonstation/rust-g/releases/download/$RUST_G_VERSION/librust_g.so"
chmod +x ./librust_g.so
ldd ./librust_g.so
cd "$original_dir"
