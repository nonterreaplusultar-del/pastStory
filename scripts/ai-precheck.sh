#!/usr/bin/env bash
set -euo pipefail

mkdir -p ai/reports
report="ai/reports/prepublish-report.md"

{
  echo "# Prepublish Report"
  echo
  echo "> 生成时间：$(date '+%F %T')"
  echo
  echo "## Git 状态"
  git status --short || true
  echo
  echo "## 私密目录跟踪检查"
  if git ls-files | grep -E '^_private/|^private/|^drafts/private/'; then
    echo "发现私密目录被 git 跟踪。"
  else
    echo "通过：没有私密目录被 git 跟踪。"
  fi
  echo
  echo "## SUMMARY.md 私密引用检查"
  if [ -f SUMMARY.md ] && grep -E '_private/|private/|drafts/private/' SUMMARY.md; then
    echo "发现 SUMMARY.md 引用了私密目录。"
  else
    echo "通过：SUMMARY.md 没有引用私密目录。"
  fi
  echo
  echo "## 构建产物跟踪检查"
  if git ls-files | grep -E '^node_modules/|^_book/'; then
    echo "发现 node_modules 或 _book 被 git 跟踪。"
  else
    echo "通过：node_modules 和 _book 未被 git 跟踪。"
  fi
} > "$report"

echo "已生成报告：$report"

./scripts/check-privacy.sh
npm run build
git status --short
