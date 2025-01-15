#!/bin/bash
set -euo pipefail

source "$1/buildByond.conf"

wget -O "$1/librust_g.so" "https://github.com/goonstation/rust-g/releases/download/$RUST_G_VERSION/librust_g.so"
chmod +x "$1/librust_g.so"
ldd "$1/librust_g.so"
