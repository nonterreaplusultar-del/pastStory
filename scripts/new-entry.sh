#!/usr/bin/env bash
set -euo pipefail

year="${1:-$(date +%Y)}"
title="${2:-未命名回忆}"
safe_title="${title// /-}"
file="$year/$(date +%m-%d)-$safe_title.md"

mkdir -p "$year"

cat > "$file" <<EOF2
# $title

> 时间：$(date +%F)  
> 地点：  
> 人物：  
> 可公开程度：公开 / 匿名后公开 / 仅自己可见  

## 发生了什么

## 当时的感受

## 后来的理解

## 想保留下来的细节

EOF2

echo "已创建：$file"
echo
echo "请把下面这一行加入 SUMMARY.md 合适的位置："
echo "  * [$title]($file)"
