#!/usr/bin/env bash
set -euo pipefail

if [ -z "${ANTHROPIC_AUTH_TOKEN:-}" ]; then
  echo "缺少 ANTHROPIC_AUTH_TOKEN。"
  echo "请在 GitHub Codespaces Secrets 中添加 DeepSeek API Key。"
  exit 1
fi

export ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic"
export ANTHROPIC_MODEL="deepseek-v4-pro[1m]"
export ANTHROPIC_DEFAULT_OPUS_MODEL="deepseek-v4-pro[1m]"
export ANTHROPIC_DEFAULT_SONNET_MODEL="deepseek-v4-pro[1m]"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="deepseek-v4-flash"
export CLAUDE_CODE_SUBAGENT_MODEL="deepseek-v4-flash"
export CLAUDE_CODE_EFFORT_LEVEL="max"

exec claude "$@"
