#!/bin/env sh

# run with sudo!
groupadd -f uinput

usermod -aG input "$USER"
usermod -aG uinput "$USER"

modprobe uinput

cat >/etc/udev/rules.d/kmonad.rules <<EOF
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
EOF

# After run and enable systemd user unit,
# WARN: User unites must not be called with sudo.
# $ systemctl --user enable --now kmonad.service
