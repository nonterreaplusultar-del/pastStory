#!/usr/bin/env bash
set -euo pipefail

echo "== AI Workspace Status =="

echo
echo "待处理任务："
find ai/tasks/inbox -type f -name "*.md" ! -name "README.md" ! -name "TASK_TEMPLATE.md" | sort || true

echo
echo "处理中任务："
find ai/tasks/doing -type f -name "*.md" ! -name "README.md" ! -name "TASK_TEMPLATE.md" | sort || true

echo
echo "已完成任务："
find ai/tasks/done -type f -name "*.md" ! -name "README.md" ! -name "TASK_TEMPLATE.md" | sort || true

echo
echo "提示词："
find ai/prompts -type f -name "*.md" ! -name "README.md" | sort || true

echo
echo "报告："
find ai/reports -type f -name "*.md" ! -name "README.md" | sort || true

echo
echo "Git 状态："
git status --short
