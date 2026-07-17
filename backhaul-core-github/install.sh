#!/usr/bin/env bash
set -Eeuo pipefail

INSTALL_DIR="${INSTALL_DIR:-/root/backhaul-core}"
SCRIPT_NAME="backhaul.sh"
BINARY_NAME="backhaul_premium"
REPO_RAW_BASE="${REPO_RAW_BASE:-https://raw.githubusercontent.com/mehdixxx-max/backhaul-core/main/backhaul-core-github}"

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Please run as root, for example:"
  echo "wget -O /root/install.sh ${REPO_RAW_BASE}/install.sh && sudo bash /root/install.sh"
  exit 1
fi

run_backhaul() {
  chmod +x "${INSTALL_DIR}/${SCRIPT_NAME}" "${INSTALL_DIR}/${BINARY_NAME}" 2>/dev/null || true
  echo "Running ${INSTALL_DIR}/${SCRIPT_NAME}"
  cd "$INSTALL_DIR"
  exec bash "$SCRIPT_NAME"
}

if [[ -f "${INSTALL_DIR}/${SCRIPT_NAME}" && -f "${INSTALL_DIR}/${BINARY_NAME}" ]]; then
  echo "Backhaul is already installed in ${INSTALL_DIR}"
  run_backhaul
fi

download_file() {
  local url="$1"
  local output="$2"
  local tmp="${output}.tmp"

  rm -f "$tmp"
  if command -v wget >/dev/null 2>&1; then
    wget -qO "$tmp" "$url"
  elif command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$tmp"
  else
    echo "curl or wget is required."
    exit 1
  fi
  mv -f "$tmp" "$output"
}

mkdir -p "$INSTALL_DIR"

download_file "${REPO_RAW_BASE}/${SCRIPT_NAME}" "${INSTALL_DIR}/${SCRIPT_NAME}"
download_file "${REPO_RAW_BASE}/${BINARY_NAME}" "${INSTALL_DIR}/${BINARY_NAME}"

echo "Installed files in ${INSTALL_DIR}"
run_backhaul
