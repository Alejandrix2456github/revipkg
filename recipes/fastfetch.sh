#!/bin/bash
# fastfetch recipe
PKG_DIR=$1  # The directory where the file was downloaded

echo "[*] Running custom recipe for fastfetch..."

# 1. Extract the tarball
tar -xvf "$PKG_DIR/fastfetch.tar.gz" -C "$PKG_DIR"

# 2. Move the binary to the local bin folder
mv "$PKG_DIR/fastfetch-linux-amd64/usr/bin/fastfetch" ~/.local/bin/fastfetch

# 3. Clean up the mess
rm -rf "$PKG_DIR/fastfetch-linux-amd64"
