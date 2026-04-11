#!/usr/bin/env bash
set -euo pipefail

# ─── Colours / helpers ───────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; NC='\033[0m'
banner() { printf "\n${CYAN}==> %s${NC}\n" "$*"; }
ok()     { printf "${GREEN} ✓  %s${NC}\n" "$*"; }
die()    { printf "${RED}ERROR: %s${NC}\n" "$*" >&2; exit 1; }

# ─── Banner ──────────────────────────────────────────────────────────
printf "\n${CYAN}╔══════════════════════════════════════╗${NC}\n"
printf "${CYAN}║   Open Harness — CLI Installer       ║${NC}\n"
printf "${CYAN}╚══════════════════════════════════════╝${NC}\n\n"

# ─── 1. Check Node.js >= 20 ──────────────────────────────────────────
banner "Checking Node.js"
if ! command -v node &>/dev/null; then
  die "Node.js is not installed. Install Node.js 20+ from: https://nodejs.org"
fi
NODE_MAJOR=$(node -e "process.exit(parseInt(process.version.slice(1)) < 20 ? 1 : 0)" 2>/dev/null \
  && node -e "process.stdout.write(process.version.split('.')[0].slice(1))" || echo "0")
if [ "$NODE_MAJOR" = "0" ] || ! node -e "if(parseInt(process.version.slice(1))<20)process.exit(1)" 2>/dev/null; then
  die "Node.js 20+ required (found $(node --version)). Upgrade at: https://nodejs.org"
fi
ok "Node.js $(node --version) — OK"

# ─── 2. Check git ────────────────────────────────────────────────────
banner "Checking git"
if ! command -v git &>/dev/null; then
  die "git is not installed. Install git from: https://git-scm.com"
fi
ok "git $(git --version | awk '{print $3}') — OK"

# ─── 3. Enable pnpm via corepack ─────────────────────────────────────
banner "Enabling pnpm via corepack"
corepack enable
corepack prepare pnpm@latest --activate
ok "pnpm $(pnpm --version) ready"

# ─── 4. Clone or update repo ─────────────────────────────────────────
INSTALL_DIR="$HOME/.openharness"
banner "Installing open-harness to $INSTALL_DIR"
if [ -d "$INSTALL_DIR/.git" ]; then
  printf "  Repository exists — pulling latest changes...\n"
  git -C "$INSTALL_DIR" pull
  ok "Repository updated"
else
  git clone https://github.com/ryaneggz/open-harness.git "$INSTALL_DIR"
  ok "Repository cloned"
fi

# ─── 5. Build and link CLI ───────────────────────────────────────────
banner "Building and linking openharness CLI"
cd "$INSTALL_DIR"
pnpm install
pnpm -r run build
pnpm link --global ./cli
ok "openharness CLI built and linked"

# ─── 6. Verify installation ──────────────────────────────────────────
banner "Verifying installation"
if ! command -v openharness &>/dev/null; then
  die "openharness command not found on PATH. Check that pnpm global bin is in your PATH."
fi
ok "openharness $(openharness --version 2>/dev/null || echo 'installed') — available on PATH"

# ─── Success ─────────────────────────────────────────────────────────
printf "\n${GREEN}Installation complete!${NC}\n\n"
printf "  ${CYAN}Next steps${NC}\n"
printf "  ──────────────────────────────────────\n"
printf "  openharness quickstart <agent-name>   # provision a new sandbox\n"
printf "  openharness shell <agent-name>        # enter a running sandbox\n"
printf "  openharness                           # interactive AI agent mode\n"
printf "\n"
