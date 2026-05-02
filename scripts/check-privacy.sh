#!/usr/bin/env bash
set -euo pipefail

echo "== Privacy Check =="

echo "1. 检查私密目录是否被 git 跟踪"
if git ls-files | grep -E '^_private/|^private/|^drafts/private/'; then
  echo "危险：发现私密文件被 git 跟踪。"
  exit 1
else
  echo "通过：没有私密文件被 git 跟踪。"
fi

echo
echo "2. 检查 SUMMARY.md 是否引用私密目录"
if [ -f SUMMARY.md ] && grep -E '_private/|private/|drafts/private/' SUMMARY.md; then
  echo "危险：SUMMARY.md 引用了私密目录。"
  exit 1
else
  echo "通过：SUMMARY.md 没有引用私密目录。"
fi

echo
echo "3. 检查构建产物和依赖是否被 git 跟踪"
if git ls-files | grep -E '^node_modules/|^_book/'; then
  echo "危险：node_modules 或 _book 被 git 跟踪。"
  exit 1
else
  echo "通过：node_modules 和 _book 未被 git 跟踪。"
fi

echo
echo "4. 检查常见密钥泄露痕迹"
if git grep -n -I -E 'sk-[A-Za-z0-9_-]{16,}|ANTHROPIC_AUTH_TOKEN=|DEEPSEEK_API_KEY=|api[_-]?key|password=' -- . ':!package-lock.json' ':!CLAUDE.md' ':!AGENTS.md' 2>/dev/null; then
  echo "警告：发现疑似密钥或密码字段，请人工确认。"
  exit 1
else
  echo "通过：未发现明显密钥。"
fi

echo
echo "隐私检查通过。"
