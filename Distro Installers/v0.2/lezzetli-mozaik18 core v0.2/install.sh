#!/bin/bash

BASE_SRC="$(cd "$(dirname "$0")" && pwd)"

BASE_DST="/opt/lezzetli-mozaik18"
BIN_DST="/usr/local/bin"

echo "Installing lezzetli18 Core v0.2..."

# create full structure
sudo mkdir -p "$BASE_DST"/{state,mounted,err,methods}

# copy core scripts
sudo cp "$BASE_SRC/pre-fs/lpkg.sh" "$BASE_DST/"
sudo cp "$BASE_SRC/pre-fs/lmpt.sh" "$BASE_DST/"
sudo cp "$BASE_SRC/pre-fs/mount.sh" "$BASE_DST/"
sudo cp "$BASE_SRC/pre-fs/version.txt" "$BASE_DST/"

# IMPORTANT: create state files if missing
sudo touch "$BASE_DST/state/on.bash18"
sudo touch "$BASE_DST/state/directory.bash18"
sudo touch "$BASE_DST/state/repository.bash18"
sudo touch "$BASE_DST/state/method.bash18"

# install CLI tools
sudo cp "$BASE_SRC/bin/lezzetli-mozaik18" "$BIN_DST/"
sudo cp "$BASE_SRC/bin/lconf" "$BIN_DST/"
sudo cp "$BASE_SRC/bin/ldoc" "$BIN_DST/"

# permissions
sudo chmod +x "$BIN_DST/"*
sudo chmod +x "$BASE_DST/"*.sh

echo "Core v0.2 installed successfully."
exit 0
