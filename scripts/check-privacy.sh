#!/usr/bin/env bash
set -euo pipefail

echo "检查是否有私密目录被 git 跟踪..."

if git ls-files | grep -E '^_private/|^drafts/private/'; then
  echo
  echo "危险：发现私密文件已经被 git 跟踪！"
  echo "请使用：git rm --cached 文件名"
  exit 1
else
  echo "通过：没有私密文件被 git 跟踪。"
fi

echo
echo "检查 SUMMARY.md 是否引用私密目录..."

if grep -E '_private/|drafts/private/' SUMMARY.md; then
  echo
  echo "危险：SUMMARY.md 引用了私密目录！"
  exit 1
else
  echo "通过：SUMMARY.md 没有引用私密目录。"
fi
