#!/usr/bin/env bash
set -euo pipefail

visibility="${1:-draft}"
year="${2:-$(date +%Y)}"
title="${3:-未命名回忆}"

safe_title=$(echo "$title" | tr ' ' '-' | tr '/' '-')
date_prefix=$(date +%m-%d)

case "$visibility" in
  public)
    dir="$year"
    template="templates/public-memory.md"
    ;;
  draft)
    dir="drafts/$year"
    template="templates/public-memory.md"
    ;;
  private)
    dir="_private/$year"
    template="templates/private-memory.md"
    ;;
  *)
    echo "用法："
    echo "  ./scripts/new-memory.sh public 2026 \"标题\""
    echo "  ./scripts/new-memory.sh draft 2026 \"标题\""
    echo "  ./scripts/new-memory.sh private 2026 \"标题\""
    exit 1
    ;;
esac

mkdir -p "$dir"
file="$dir/$date_prefix-$safe_title.md"

cp "$template" "$file"

sed -i "1s/.*/# $title/" "$file"

echo "已创建：$file"

if [ "$visibility" = "public" ]; then
  echo
  echo "如果要显示在 GitBook，请把下面这一行加入 SUMMARY.md："
  echo "  * [$title]($file)"
fi

if [ "$visibility" = "private" ]; then
  echo
  echo "这是私密文件，已放入 _private/，不会被 git 提交。"
fi
