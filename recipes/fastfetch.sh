#!/bin/bash
FILE=$1
APP_NAME=$2
TEMP_DIR="/tmp/revipkg_$APP_NAME"

echo "[*] Unpacking $APP_NAME..."
mkdir -p "$TEMP_DIR"

if tar -xf "$FILE" -C "$TEMP_DIR"; then
    # FIX: Specifically look for an ELF binary (the actual compiled program)
    # This ignores shell scripts and folders named 'fastfetch'
    BINARY_PATH=$(find "$TEMP_DIR" -type f -executable -exec sh -c "file {} | grep -q 'ELF'" \; -print | head -n 1)
    
    if [ -n "$BINARY_PATH" ]; then
        # Remove the old "fake" one first
        rm -f "$HOME/.local/bin/$APP_NAME"
        
        mv "$BINARY_PATH" "$HOME/.local/bin/$APP_NAME"
        chmod +x "$HOME/.local/bin/$APP_NAME"
        echo "[+] Real binary installed to ~/.local/bin/$APP_NAME"
        
        rm -rf "$TEMP_DIR" "$FILE"
        exit 0
    else
        echo "[!] Error: Could not find the compiled ELF binary for $APP_NAME."
        exit 1
    fi
else
    echo "[!] Error: Extraction failed."
    exit 1
fi
