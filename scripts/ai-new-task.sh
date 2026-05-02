#!/usr/bin/env bash
set -euo pipefail

type="${1:-general}"
title="${2:-未命名任务}"
date_str="$(date +%F)"
safe_title="$(echo "$title" | tr ' /' '--')"
file="ai/tasks/inbox/${date_str}-${type}-${safe_title}.md"

mkdir -p ai/tasks/inbox

cat > "$file" <<EOF2
# $title

> 状态：待处理  
> 类型：$type  
> 创建时间：$date_str  
> 目标年份：  
> 目标文件：  
> 是否允许修改原文：否  
> 是否允许加入 GitBook：否  
> 是否允许提交：否  
> 是否允许 push：否  

## 任务目标

请在这里写清楚希望 AI 完成什么。

## 输入素材

请在这里放可以公开处理的素材。

## 风格要求

- 保留作者原本语气
- 不要公众号腔
- 不要鸡汤
- 不要过度煽情
- 不要虚构经历

## 输出要求

- 输出到：
- 是否需要更新 SUMMARY.md：
- 是否需要生成报告：

## 完成后必须运行

- ./scripts/check-privacy.sh
- npm run build
- git status
EOF2

echo "已创建任务：$file"
