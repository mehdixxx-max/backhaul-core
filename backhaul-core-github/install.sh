#!/usr/bin/env bash
set -Eeuo pipefail

INSTALL_DIR="${INSTALL_DIR:-/root/backhaul-core}"
SCRIPT_NAME="backhaul.sh"
BINARY_NAME="backhaul_premium"

REPO_RAW_BASE="${REPO_RAW_BASE:-https://raw.githubusercontent.com/mehdixxx-max/backhaul-core/main/backhaul-core-github}"

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Please run as root, for example:"
  echo "curl -fsSL ${REPO_RAW_BASE}/install.sh | sudo bash"
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
