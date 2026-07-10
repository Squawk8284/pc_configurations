#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing PC configuration..."

# Install dotfiles
"$ROOT_DIR/dotfiles/dotfile_install.sh"

# Configure GPG
"$ROOT_DIR/scripts/setup_gpg.sh"

# Future installers
# "$ROOT_DIR/packages/install.sh"
# "$ROOT_DIR/fonts/install.sh"
# "$ROOT_DIR/vscode/install.sh"
# "$ROOT_DIR/scripts/install.sh"

echo "Installation complete."
echo "  Restart your terminal or"
echo "  source ~/.bashrc"
