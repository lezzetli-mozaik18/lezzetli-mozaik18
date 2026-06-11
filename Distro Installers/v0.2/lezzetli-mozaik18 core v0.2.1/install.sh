#!/bin/bash

BASE_SRC="$(cd "$(dirname "$0")" && pwd)"

BASE_DST="/opt/lezzetli-mozaik18"
BIN_DST="/usr/local/bin"

echo "Installing lezzetli18 Core v0.2.1..."

# ensure bootstrap is executable (no need to re-bash twice)
sudo chmod +x "$BASE_SRC/bootstrap.sh" || exit 1
sudo bash "$BASE_SRC/bootstrap.sh" || exit 1

# create structure
sudo mkdir -p "$BASE_DST"/{state,mounted,err,methods,updates}

# copy core scripts (clean + explicit)
sudo cp "$BASE_SRC/pre-fs/lpkg.sh" "$BASE_DST/"
sudo cp "$BASE_SRC/pre-fs/lmpt.sh" "$BASE_DST/"
sudo cp "$BASE_SRC/pre-fs/mount.sh" "$BASE_DST/"
sudo cp "$BASE_SRC/pre-fs/mpkg.sh" "$BASE_DST/"
sudo cp "$BASE_SRC/pre-fs/config.sh" "$BASE_DST/"
sudo cp "$BASE_SRC/pre-fs/config-nonint.sh" "$BASE_DST/"
sudo cp "$BASE_SRC/pre-fs/version.txt" "$BASE_DST/"
sudo cp "$BASE_SRC/pre-fs/uninstall.txt" "$BASE_DST/"

# uninstall pointer (fix: no useless echo piping)
echo "$BASE_SRC/uninstall.sh" | sudo tee "$BASE_DST/uninstall.txt" > /dev/null

# state files
sudo touch \
"$BASE_DST/state/on.bash18" \
"$BASE_DST/state/directory.bash18" \
"$BASE_DST/state/repository.bash18" \
"$BASE_DST/state/method.bash18"

sudo touch "$BASE_DST/methods/example.m18"

# originality marker (demo-only, correct handling)
echo "This does NOT verify package originality! DO NOT DELETE" | \
sudo tee "$BASE_DST/originality.verif" > /dev/null

# install CLI tools
sudo cp "$BASE_SRC/bin/lezzetli-mozaik18" "$BIN_DST/"
sudo cp "$BASE_SRC/bin/lconf" "$BIN_DST/"
sudo cp "$BASE_SRC/bin/ldoc" "$BIN_DST/"

# permissions (safe version)
sudo chmod +x "$BIN_DST/lezzetli-mozaik18"
sudo chmod +x "$BIN_DST/lconf"
sudo chmod +x "$BIN_DST/ldoc"

sudo chmod +x "$BASE_DST"/*.sh 2>/dev/null

echo "Core v0.2.1 installed successfully."
exit 0
