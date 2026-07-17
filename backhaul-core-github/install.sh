#!/usr/bin/env bash
set -Eeuo pipefail

INSTALL_DIR="${INSTALL_DIR:-/root/backhaul-core}"
SCRIPT_NAME="backhaul.sh"
BINARY_NAME="backhaul_premium"

# After uploading this repository to GitHub, replace OWNER/REPO below or pass
# REPO_RAW_BASE in the one-line install command.
DEFAULT_REPO_RAW_BASE="https://raw.githubusercontent.com/OWNER/REPO/main"
REPO_RAW_BASE="${REPO_RAW_BASE:-$DEFAULT_REPO_RAW_BASE}"

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Please run as root, for example:"
  echo "curl -fsSL ${REPO_RAW_BASE}/install.sh | sudo bash"
  exit 1
fi

if [[ "$REPO_RAW_BASE" == *"OWNER/REPO"* ]]; then
  echo "REPO_RAW_BASE is not configured."
  echo "Either edit install.sh after uploading to GitHub, or run:"
  echo "curl -fsSL https://raw.githubusercontent.com/OWNER/REPO/main/install.sh | REPO_RAW_BASE=https://raw.githubusercontent.com/OWNER/REPO/main bash"
  exit 1
fi

download_file() {
  local url="$1"
  local output="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$output"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$output" "$url"
  else
    echo "curl or wget is required."
    exit 1
  fi
}

mkdir -p "$INSTALL_DIR"

download_file "${REPO_RAW_BASE}/${SCRIPT_NAME}" "${INSTALL_DIR}/${SCRIPT_NAME}"
download_file "${REPO_RAW_BASE}/${BINARY_NAME}" "${INSTALL_DIR}/${BINARY_NAME}"

chmod +x "${INSTALL_DIR}/${SCRIPT_NAME}" "${INSTALL_DIR}/${BINARY_NAME}"

echo "Installed files in ${INSTALL_DIR}"
cd "$INSTALL_DIR"
exec bash "$SCRIPT_NAME"
