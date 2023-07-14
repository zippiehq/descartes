#!/bin/bash

# Run yarn commands
yarn 
yarn clean
yarn build
yarn copy-dts

# Destination folder
DEST="../../compute"
# Empty folder
if [ -d "$DEST" ]; then
    rm -r $DEST/*
fi

# Create the destination dist and export directories if they don't exist
mkdir -p $DEST/dist
mkdir -p $DEST/export/artifacts
mkdir -p $DEST/export/abi

# List of directories to copy
DIRS=("contracts" "deployments")

# Copy directories to destination
for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ]; then
        cp -R "$dir" $DEST/
    else
        echo "Directory $dir does not exist."
    fi
done

# Copy non .ts files from dist/deploy to dist/deploy in the destination directory
if [ -d "dist/deploy" ]; then
    for file in $(find dist/deploy -type f ! -name "*.ts"); do
        mkdir -p "$DEST/$(dirname "$file")"
        cp "$file" "$DEST/$file"
    done
else
    echo "Directory dist/deploy does not exist."
fi

# Copy dist/src/types to dist in the destination directory
if [ -d "dist/src/types" ]; then
    mkdir -p $DEST/dist/src
    cp -R "dist/src/types" $DEST/dist/src/
else
    echo "Directory dist/src/types does not exist."
fi

# Copy the contents of export/artifacts to export/artifacts in the destination directory
if [ -d "export/abi" ]; then
    mkdir -p "$DEST/export/artifacts"
    cp -R "export/artifacts/"* "$DEST/export/artifacts"
else
    echo "Directory export/abi does not exist."
fi

# Copy the contents of export/abi to export/abi in the destination directory
if [ -d "export/abi" ]; then
    mkdir -p "$DEST/export/abi"
    cp -R "export/abi/"* "$DEST/export/abi"
else
    echo "Directory export/abi does not exist."
fi

# List of files to copy
FILES=("COPYING" "package.json" "README.md")

# Copy files to destination
for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        cp "$file" $DEST/
    else
        echo "File $file does not exist."
    fi
done
