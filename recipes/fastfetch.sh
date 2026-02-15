#!/bin/bash
FILE=$1       # This is /home/alrx/.revipkg/apps/fastfetch.tmp
APP_NAME=$2
TEMP_DIR="/tmp/revipkg_$APP_NAME"

echo "[*] Unpacking $APP_NAME..."
mkdir -p "$TEMP_DIR"

# Extract the file directly. $FILE is the path to the downloaded tar.gz
if tar -xf "$FILE" -C "$TEMP_DIR"; then
    # Use find to locate the binary regardless of the folder name inside the tar
    BINARY=$(find "$TEMP_DIR" -type f -name "$APP_NAME" | head -n 1)
    
    if [ -n "$BINARY" ]; then
        mv "$BINARY" "$HOME/.local/bin/$APP_NAME"
        chmod +x "$HOME/.local/bin/$APP_NAME"
        rm -rf "$TEMP_DIR" "$FILE"
        exit 0 # Success!
    else
        echo "[!] Error: Binary $APP_NAME not found inside archive."
        exit 1
    fi
else
    echo "[!] Error: Failed to extract $FILE"
    exit 1
fi
