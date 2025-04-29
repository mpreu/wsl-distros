#!/bin/bash
# The Fedora WSL out of box experience script.
#
# This command runs the first time the user opens an interactive shell.
#
# A non-zero exit code indicates to WSL that setup failed.

set -ueo pipefail

DEFAULT_USER_ID=1000
username=fedora

if getent passwd $DEFAULT_USER_ID > /dev/null ; then
  echo 'User account already exists, skipping creation'
  exit 0
fi

# Create the user.
/usr/sbin/useradd -m -G wheel,kvm,libvirt --uid $DEFAULT_USER_ID "$username"

cat > /etc/sudoers.d/wsluser << EOF
# Ensure the WSL initial user can use sudo without a password.
$username ALL=(ALL) NOPASSWD: ALL
EOF

# Set the default user; necessary when this script is manually run in versions
# of WSL prior to 2.4.
cat >> /etc/wsl.conf << EOF

[user]
default = "$username"
EOF

loginctl enable-linger $username

mkdir -p /home/$username/.bashrc.d

cat >> /home/$username/.bashrc.d/wsl.sh << EOF
export DONT_PROMPT_WSL_INSTALL=true
EOF
