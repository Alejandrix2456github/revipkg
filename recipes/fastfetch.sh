#!/bin/bash
# $1 is the downloaded file (/home/alrx/.revipkg/apps/fastfetch.tmp)
# $2 is the app name (fastfetch)
FILE=$1
APP_NAME=$2
TEMP_DIR="/tmp/revipkg_$APP_NAME"

echo "[*] Unpacking $APP_NAME..."
mkdir -p "$TEMP_DIR"

# FIX: Extract the file directly. $FILE is the archive itself.
if tar -xf "$FILE" -C "$TEMP_DIR"; then
    # Search for the binary inside the extracted contents
    BINARY_PATH=$(find "$TEMP_DIR" -type f -name "fastfetch" | head -n 1)
    
    if [ -n "$BINARY_PATH" ]; then
        mv "$BINARY_PATH" "$HOME/.local/bin/$APP_NAME"
        chmod +x "$HOME/.local/bin/$APP_NAME"
        echo "[+] Successfully moved $APP_NAME to ~/.local/bin"
        
        # Cleanup
        rm -rf "$TEMP_DIR" "$FILE"
        exit 0
    else
        echo "[!] Error: Could not find 'fastfetch' binary in archive."
        exit 1
    fi
else
    echo "[!] Error: tar failed to extract $FILE"
    exit 1
fi
