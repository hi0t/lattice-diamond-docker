#!/bin/bash
set -e

# Get the UID/GID from environment variables or default to 1000
USER_UID=${USER_UID:-1000}
USER_GID=${USER_GID:-1000}
USER_NAME="diamond"

# Check if the group exists, if not create it
if ! getent group "$USER_GID" >/dev/null; then
    groupadd --gid "$USER_GID" "$USER_NAME"
fi

# Check if the user exists, if not create it
if ! getent passwd "$USER_UID" >/dev/null; then
    useradd --uid "$USER_UID" --gid "$USER_GID" --shell /bin/bash --create-home "$USER_NAME"
    echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER_NAME
    chmod 0440 /etc/sudoers.d/$USER_NAME
fi

# Switch to the user and run the command
exec sudo -E -u "#$USER_UID" env "PATH=$PATH" "$@"
