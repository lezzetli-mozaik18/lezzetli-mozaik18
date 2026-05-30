#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
chmod +x "$BASE_DIR/install.sh"
chmod +x "$BASE_DIR/uninstall.sh"
chmod +x "$BASE_DIR/pre-fs/lmpt.sh"
chmod +x "$BASE_DIR/pre-fs/lpkg.sh"
chmod +x "$BASE_DIR/pre-fs/mount.sh"
chmod +x "$BASE_DIR/bin/lezzetli-mozaik18"
exit 0
