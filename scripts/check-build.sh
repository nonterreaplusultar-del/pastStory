#!/usr/bin/env bash
set -euo pipefail

echo "== Build Check =="

if [ ! -f package.json ]; then
  echo "缺少 package.json"
  exit 1
fi

npm run build

echo "构建通过。"
