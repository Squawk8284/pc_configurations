#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from: $DOTFILES"

# Symlink top-level dotfiles
for file in "$DOTFILES"/*; do
    [[ -e "$file" ]] || continue

    name="$(basename "$file")"

    # Skip installer and directories
    [[ "$name" == "install.sh" ]] && continue
    [[ "$name" == "config" ]] && continue
    [[ -d "$file" ]] && continue

    echo "Linking ~/.${name} -> ${file}"
    ln -sfn "$file" "$HOME/.${name}"
done

# Symlink ~/.config entries
if [[ -d "$DOTFILES/config" ]]; then
    mkdir -p "$HOME/.config"

    for entry in "$DOTFILES/config"/*; do
        [[ -e "$entry" ]] || continue

        name="$(basename "$entry")"

        echo "Linking ~/.config/${name} -> ${entry}"
        ln -sfn "$entry" "$HOME/.config/${name}"
    done
fi

echo "Done!"
