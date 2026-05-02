#!/usr/bin/env bash
set -euo pipefail

echo "== Install basic dependencies =="
sudo apt-get update
sudo apt-get install -y git-lfs curl ca-certificates gnupg

echo "== Setup Git LFS =="
git lfs install || true

echo "== Install project dependencies =="
if [ -f package.json ]; then
  npm install
fi

echo "== Install Claude Code via apt =="
if ! command -v claude >/dev/null 2>&1; then
  sudo install -d -m 0755 /etc/apt/keyrings

  sudo curl -fsSL https://downloads.claude.ai/keys/claude-code.asc \
    -o /etc/apt/keyrings/claude-code.asc

  echo "deb [signed-by=/etc/apt/keyrings/claude-code.asc] https://downloads.claude.ai/claude-code/apt/stable stable main" \
    | sudo tee /etc/apt/sources.list.d/claude-code.list >/dev/null

  sudo apt-get update
  sudo apt-get install -y claude-code
fi

echo "== Verify Claude Code =="
command -v claude
claude --version

echo "== Codespace setup complete =="
