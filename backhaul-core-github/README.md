# Backhaul Core

This repository installs `backhaul.sh` and `backhaul_premium` into:

```bash
/root/backhaul-core
```

## One-line install and run

After uploading these files to GitHub, replace `OWNER/REPO` with your repository name:

```bash
curl -fsSL https://raw.githubusercontent.com/OWNER/REPO/main/install.sh | REPO_RAW_BASE=https://raw.githubusercontent.com/OWNER/REPO/main bash
```

The installer will:

- create `/root/backhaul-core`
- download `backhaul.sh`
- download `backhaul_premium`
- run `chmod +x` on both files
- run the script with:

```bash
cd /root/backhaul-core
bash backhaul.sh
```

## Optional: simpler command

If you edit `install.sh` and replace this line:

```bash
DEFAULT_REPO_RAW_BASE="https://raw.githubusercontent.com/OWNER/REPO/main"
```

with your real GitHub raw URL, users can run only:

```bash
curl -fsSL https://raw.githubusercontent.com/OWNER/REPO/main/install.sh | bash
```

## Files

- `backhaul.sh`: main script
- `backhaul_premium`: binary file used by the script
- `install.sh`: GitHub installer
