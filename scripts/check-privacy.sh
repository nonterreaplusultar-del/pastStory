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

secret_pattern='sk-[A-Za-z0-9_-]{20,}|(ANTHROPIC_AUTH_TOKEN|DEEPSEEK_API_KEY|OPENAI_API_KEY|GITHUB_TOKEN)[[:space:]]*=[[:space:]]*["'\'']?[^"'\''[:space:]]{8,}'

secret_locations() {
  sed -E 's#^\./##; s/^([^:]+:[0-9]+):.*$/\1/'
}

tracked_secret_hits="$(
  git grep -n -I -E "$secret_pattern" \
    -- . \
    ':!package-lock.json' \
    ':!**/package-lock.json' \
    ':!node_modules/**' \
    ':!_book/**' \
    ':!_private/**' \
    ':!private/**' \
    ':!drafts/private/**' \
    ':!.env.local' \
    ':!scripts/check-privacy.sh' \
    2>/dev/null | secret_locations || true
)"

workspace_secret_hits="$(
  find . \
    \( \
      -path './_private' -o -path './_private/*' -o \
      -path './private' -o -path './private/*' -o \
      -path './drafts/private' -o -path './drafts/private/*' -o \
      -path './.git' -o -path './.git/*' -o \
      -path './node_modules' -o -path './node_modules/*' -o \
      -path './_book' -o -path './_book/*' \
    \) -prune -o \
    -type f \
    ! -name 'package-lock.json' \
    ! -name '.env.local' \
    ! -path './scripts/check-privacy.sh' \
    -print0 |
  xargs -0 grep -n -I -E "$secret_pattern" 2>/dev/null |
  secret_locations || true
)"

secret_hits="$(
  printf '%s\n%s\n' "$tracked_secret_hits" "$workspace_secret_hits" |
    sed '/^$/d' |
    sort -u
)"

if [ -n "$secret_hits" ]; then
  echo "$secret_hits"
  echo
  echo "警告：发现疑似密钥或密码字段，请人工确认。"
  exit 1
else
  echo "通过：未发现明显密钥。"
fi

echo
echo "隐私检查通过。"
