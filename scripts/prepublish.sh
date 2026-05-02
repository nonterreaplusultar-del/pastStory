#!/usr/bin/env bash
set -euo pipefail

echo "== Prepublish Check =="

./scripts/check-privacy.sh
./scripts/check-build.sh

echo
echo "== Git Status =="
git status --short

echo
echo "发布前检查完成。"
