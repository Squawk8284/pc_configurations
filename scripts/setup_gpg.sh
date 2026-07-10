#!/usr/bin/env bash

set -euo pipefail

echo "Configuring GPG..."

# Install required packages
sudo apt update
sudo apt install -y gnupg pinentry-curses

mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"

cat > "$HOME/.gnupg/gpg-agent.conf" <<EOF
pinentry-program /usr/bin/pinentry-curses
EOF

chmod 600 "$HOME/.gnupg/gpg-agent.conf"

# Ensure GPG_TTY is exported
if ! grep -q 'export GPG_TTY=\$(tty)' "$HOME/.bashrc"; then
    cat <<'EOF' >> "$HOME/.bashrc"

# GPG terminal support
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
EOF
fi

gpgconf --kill gpg-agent || true

echo "✓ GPG configured."
