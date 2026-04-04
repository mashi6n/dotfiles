#!/usr/bin/env bash
set -euo pipefail

USER_NAME="${USER}"
OS="$(uname -s)"
ARCH="$(uname -m)"

case "$ARCH" in
  arm64) ARCH="aarch64" ;;
  x86_64) ARCH="x86_64" ;;
esac

case "$OS" in
  Darwin) PLATFORM="darwin" ;;
  Linux) PLATFORM="linux" ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac

if [ "$PLATFORM" = "darwin" ]; then
  if [ "$USER_NAME" = "mashi6n" ]; then
    HOST="mashi6n"
  elif [ "$USER_NAME" = "mashiro.toyooka" ]; then
    HOST="mashiro-toyooka"
  else
    echo "Unknown Darwin user: $USER_NAME"
    exit 1
  fi
else
  HOST="ubuntu-${ARCH}"
fi

echo "Detected host: $HOST"

nix run ".#homeConfigurations.${HOST}.activationPackage"

if [ "$PLATFORM" = "darwin" ]; then
  sudo nix run nix-darwin -- switch --flake ".#${HOST}"
fi
