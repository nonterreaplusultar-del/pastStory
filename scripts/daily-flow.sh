#!/usr/bin/env bash
set -euo pipefail

echo "== Daily Memoir Flow =="

echo
echo "1. AI 工作区状态"
./scripts/ai-status.sh || true

echo
echo "2. 隐私检查"
./scripts/check-privacy.sh

echo
echo "3. GitBook 构建检查"
npm run build

echo
echo "4. Git 状态"
git status --short

echo
echo "日常流程检查完成。"
