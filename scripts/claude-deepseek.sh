#!/usr/bin/env bash
set -euo pipefail

if [ -z "${ANTHROPIC_AUTH_TOKEN:-}" ]; then
  echo "缺少 ANTHROPIC_AUTH_TOKEN。"
  echo "请在 GitHub Codespaces Secrets 中添加 DeepSeek API Key。"
  exit 1
fi

if ! command -v claude >/dev/null 2>&1; then
  echo "未找到 claude 命令。"
  echo "请先运行：bash scripts/setup-codespace.sh"
  exit 1
fi

export ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic"
export ANTHROPIC_MODEL="deepseek-v4-pro"
export ANTHROPIC_DEFAULT_OPUS_MODEL="deepseek-v4-pro"
export ANTHROPIC_DEFAULT_SONNET_MODEL="deepseek-v4-pro"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="deepseek-v4-flash"
export CLAUDE_CODE_SUBAGENT_MODEL="deepseek-v4-flash"
export CLAUDE_CODE_EFFORT_LEVEL="max"

exec claude "$@"
