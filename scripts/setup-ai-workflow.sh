#!/usr/bin/env bash
set -euo pipefail

mkdir -p ai/prompts ai/reports ai/tasks
mkdir -p ai/tasks/inbox ai/tasks/doing ai/tasks/done ai/tasks/archive
mkdir -p .claude/commands scripts

echo "== 写入 ai/README.md =="

cat > ai/README.md <<'EOT'
# AI 工作区

这个目录用于管理 Claude + DeepSeek 在 pastStory 回忆录项目中的自动化流程。

## 目录结构

- `tasks/`：任务单
- `tasks/inbox/`：待处理任务
- `tasks/doing/`：处理中任务
- `tasks/done/`：已完成任务
- `tasks/archive/`：归档任务
- `prompts/`：长期提示词模板
- `reports/`：AI 生成的检查报告和处理报告

## 标准流程

1. 用户在 `ai/tasks/inbox/` 创建任务单。
2. Claude / DeepSeek 读取任务单。
3. 根据任务类型修改草稿、文章、目录或生成报告。
4. 运行隐私检查。
5. 运行 GitBook 构建检查。
6. 生成处理报告到 `ai/reports/`。
7. 用户确认后再提交和推送。

## 核心原则

- 不读取 `_private/`
- 不提交 `private/` 或 `_private/`
- 不擅自公开草稿
- 不擅自修改 `SUMMARY.md`
- 不虚构作者经历
- 不自动 push，除非用户明确要求
EOT

echo "== 写入 ai/tasks 规则 =="

cat > ai/tasks/README.md <<'EOT'
# AI 任务单目录

这里放交给 Claude + DeepSeek 的任务。

## 推荐任务类型

- `new-memory`：新建回忆
- `polish`：润色文章
- `summary`：更新 GitBook 目录
- `privacy`：隐私检查
- `year-review`：年度整理
- `prepublish`：发布前检查
- `mobile-inbox`：整理手机端临时记录

## 任务状态

任务文件建议从 `inbox/` 开始。

处理时移动到：

- `doing/`
- `done/`
- `archive/`

## 注意

任务单本身可以提交，但不要把 API Key、聊天原文、真实隐私信息写进任务单。
EOT

cat > ai/tasks/TASK_TEMPLATE.md <<'EOT'
# 任务标题

> 状态：待处理  
> 类型：new-memory / polish / summary / privacy / year-review / prepublish / mobile-inbox  
> 创建时间：  
> 目标年份：  
> 目标文件：  
> 是否允许修改原文：否  
> 是否允许加入 GitBook：否  
> 是否允许提交：否  
> 是否允许 push：否  

## 任务目标

在这里写清楚希望 AI 完成什么。

## 输入素材

放入可以公开处理的素材。

不要写入 API Key、密码、真实聊天隐私、身份证明、手机号、住址等内容。

## 风格要求

- 保留作者原本语气
- 真诚、克制、有叙事感
- 不要公众号腔
- 不要鸡汤
- 不要过度煽情
- 不要虚构经历

## 输出要求

- 输出位置：
- 是否需要生成报告：
- 是否需要更新 SUMMARY.md：

## 完成后必须运行

- ./scripts/check-privacy.sh
- npm run build
- git status
EOT

cat > ai/tasks/inbox/README.md <<'EOT'
# Inbox

这里放待处理任务。

可以用下面命令快速创建任务：

`./scripts/ai-new-task.sh polish "润色某篇回忆"`
EOT

cat > ai/tasks/doing/README.md <<'EOT'
# Doing

这里放正在处理的任务。
EOT

cat > ai/tasks/done/README.md <<'EOT'
# Done

这里放已经完成的任务。
EOT

cat > ai/tasks/archive/README.md <<'EOT'
# Archive

这里放过期、废弃或历史任务。
EOT

echo "== 写入 ai/prompts 提示词 =="

cat > ai/prompts/README.md <<'EOT'
# 提示词模板

这里存放 Claude + DeepSeek 的长期提示词。

这些提示词用于让 AI 稳定执行你的日常流程，而不是每次重新解释项目。
EOT

cat > ai/prompts/project-rules.md <<'EOT'
# 项目总规则提示词

你正在处理 pastStory 个人回忆录项目。

你的身份是编辑助理、整理助理和项目维护助手，不是作者本人。

## 必须遵守

1. 不读取 `_private/`。
2. 不提交 `private/` 或 `_private/`。
3. 不擅自公开草稿。
4. 不擅自把 `drafts/` 加入 `SUMMARY.md`。
5. 不虚构作者经历。
6. 不删除原文中的关键细节。
7. 不泄露真实姓名、手机号、邮箱、住址、证件、聊天截图、API Key、Token、密码。
8. 不自动 push，除非用户明确要求。

## 每次完成任务后

必须运行：

- `./scripts/check-privacy.sh`
- `npm run build`
- `git status`

并生成简短处理报告。
EOT

cat > ai/prompts/memoir-editor.md <<'EOT'
# 回忆录编辑提示词

你是个人回忆录项目的文字编辑。

## 任务

润色、整理、拆分或补全回忆录文章。

## 风格

- 真诚
- 克制
- 有叙事感
- 保留作者语气
- 不要公众号腔
- 不要鸡汤
- 不要过度文学化
- 不要明显 AI 味

## 编辑原则

1. 修正错别字和病句。
2. 优化段落连接。
3. 保留有真实感的细节。
4. 不改写事实。
5. 不虚构经历。
6. 不把普通回忆拔高成宏大叙事。
7. 涉及他人隐私时，建议匿名化。

## 输出

如果用户没有明确说“直接覆盖”，默认生成草稿，不覆盖原文。
EOT

cat > ai/prompts/mobile-inbox.md <<'EOT'
# 手机端灵感整理提示词

你是手机端临时记录整理助手。

## 任务

读取 `drafts/mobile-inbox.md` 中的公开临时记录，将其整理成：

1. 待写任务
2. 可公开草稿
3. 需要私下保存的提醒
4. 可以加入正式年份目录的文章建议

## 规则

- 不读取 `_private/`
- 不擅自公开
- 不擅自加入 `SUMMARY.md`
- 不删除 mobile-inbox 原文，除非用户明确要求
- 整理结果优先输出到 `ai/reports/mobile-inbox-report.md`

## 输出结构

- 今日新增素材
- 可整理成文章的素材
- 建议放入哪个年份
- 是否适合公开
- 下一步建议
EOT

cat > ai/prompts/gitbook-summary.md <<'EOT'
# GitBook 目录维护提示词

你是 GitBook 目录维护助手。

## 任务

维护 `SUMMARY.md`。

## 规则

1. 只加入公开文章。
2. 不加入 `_private/`。
3. 不加入 `private/`。
4. 不加入 `drafts/`，除非用户明确要求公开。
5. 不重复引用同一个 Markdown 文件。
6. 按年份组织。
7. 链接使用相对路径。
8. 修改后运行 `npm run build`。

## 完成后

输出：

- 新增了哪些目录项
- 是否发现重复链接
- 是否发现不存在的文件
- 是否构建通过
EOT

cat > ai/prompts/privacy-review.md <<'EOT'
# 隐私检查提示词

你是回忆录项目的隐私检查助手。

## 检查对象

公开年份目录、`README.md`、`SUMMARY.md`、`drafts/` 中准备公开的文件。

## 禁止

不读取 `_private/`。

## 重点检查

1. 真实姓名
2. 手机号
3. 邮箱
4. 住址
5. 身份证、证件号
6. 学校班级、宿舍号、具体单位
7. 聊天截图或聊天原文
8. 他人的隐私经历
9. API Key、Token、密码
10. 不适合公开的强烈情绪内容

## 输出方式

不要复制完整隐私原文。

只输出：

- 文件位置
- 风险类型
- 建议处理方式
- 是否建议匿名化
EOT

cat > ai/prompts/year-review.md <<'EOT'
# 年度整理提示词

你是年度回忆整理助手。

## 任务

根据指定年份目录中的公开文章，生成年度回顾草稿。

## 规则

1. 只读取指定年份目录。
2. 不读取 `_private/`。
3. 不虚构经历。
4. 不修改原文。
5. 输出到 `drafts/year-review-年份.md`。
6. 语气像作者自己的回望，不要像工作总结。

## 输出结构

# 年度回顾标题

## 这一年的主要事件

## 这一年的情绪变化

## 重要人物与关系

## 现在回头看

## 还可以继续补充的地方
EOT

cat > ai/prompts/prepublish.md <<'EOT'
# 发布前检查提示词

你是发布前检查助手。

## 任务

检查项目是否适合推送到 GitBook。

## 必须检查

1. `SUMMARY.md` 是否引用不存在的文件。
2. `SUMMARY.md` 是否引用 `_private/`、`private/` 或 `drafts/private/`。
3. `_private/` 或 `private/` 是否被 git 跟踪。
4. `node_modules/` 或 `_book/` 是否被 git 跟踪。
5. 是否存在明显 API Key、Token、密码。
6. `npm run build` 是否通过。
7. `git status` 是否干净。

## 输出

报告写入 `ai/reports/prepublish-report.md`。
EOT

echo "== 写入 ai/reports 说明 =="

cat > ai/reports/README.md <<'EOT'
# AI 报告目录

这里存放 AI 生成的报告。

## 常见报告

- `task-report.md`
- `prepublish-report.md`
- `privacy-report.md`
- `mobile-inbox-report.md`
- `summary-check-report.md`
- `year-review-年份.md`

## 报告原则

1. 报告可以描述风险，但不要复制完整隐私原文。
2. 报告可以指出文件路径和问题类型。
3. 报告不要包含 API Key、Token、密码。
4. 报告可以提交到仓库。
EOT

touch ai/reports/.gitkeep

echo "== 写入脚本 =="

cat > scripts/ai-new-task.sh <<'EOT'
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
EOT

chmod +x scripts/ai-new-task.sh

cat > scripts/ai-status.sh <<'EOT'
#!/usr/bin/env bash
set -euo pipefail

echo "== AI Workspace Status =="

echo
echo "待处理任务："
find ai/tasks/inbox -type f -name "*.md" | sort || true

echo
echo "处理中任务："
find ai/tasks/doing -type f -name "*.md" | sort || true

echo
echo "已完成任务："
find ai/tasks/done -type f -name "*.md" | sort || true

echo
echo "提示词："
find ai/prompts -type f -name "*.md" | sort || true

echo
echo "报告："
find ai/reports -type f -name "*.md" | sort || true

echo
echo "Git 状态："
git status --short
EOT

chmod +x scripts/ai-status.sh

cat > scripts/ai-precheck.sh <<'EOT'
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
EOT

chmod +x scripts/ai-precheck.sh

cat > scripts/daily-flow.sh <<'EOT'
#!/usr/bin/env bash
set -euo pipefail

echo "== Daily Memoir Flow =="

echo
echo "1. AI 工作区状态"
./scripts/ai-status.sh || true

echo
echo "2. 隐私检查"
./scripts/check-privacy.sh

echo
echo "3. GitBook 构建检查"
npm run build

echo
echo "4. Git 状态"
git status --short

echo
echo "日常流程检查完成。"
EOT

chmod +x scripts/daily-flow.sh

echo "== 写入 Claude 命令 =="

cat > .claude/commands/process-ai-task.md <<'EOT'
# process-ai-task

读取用户指定的 `ai/tasks/inbox/*.md` 任务单，并完成对应工作。

## 执行流程

1. 阅读 `CLAUDE.md`。
2. 阅读指定任务单。
3. 判断任务类型。
4. 不读取 `_private/`。
5. 不擅自公开草稿。
6. 不擅自更新 `SUMMARY.md`，除非任务单允许。
7. 不自动提交或 push，除非任务单允许。
8. 完成后生成报告到 `ai/reports/task-report.md`。

## 完成后必须运行

- `./scripts/check-privacy.sh`
- `npm run build`
- `git status`

## 最终回复

说明：

1. 完成了什么
2. 修改了哪些文件
3. 是否存在隐私风险
4. 是否需要用户确认
5. 下一步建议
EOT

cat > .claude/commands/daily-flow.md <<'EOT'
# daily-flow

执行 pastStory 回忆录项目的日常流程检查。

## 必须运行

- `./scripts/ai-status.sh`
- `./scripts/check-privacy.sh`
- `npm run build`
- `git status`

## 输出

给出简短报告：

1. 当前待处理任务
2. 是否存在隐私风险
3. GitBook 构建是否通过
4. 当前 Git 状态
5. 下一步建议
EOT

cat > .claude/commands/mobile-inbox.md <<'EOT'
# mobile-inbox

整理 `drafts/mobile-inbox.md` 中的手机端临时记录。

## 规则

1. 不删除原文。
2. 不擅自公开。
3. 不擅自加入 `SUMMARY.md`。
4. 不读取 `_private/`。
5. 整理结果写入 `ai/reports/mobile-inbox-report.md`。

## 输出报告包括

- 哪些内容适合整理成正式文章
- 建议放入哪个年份目录
- 是否适合公开
- 下一步建议
EOT

echo "== 更新 package.json scripts =="

if [ -f package.json ]; then
  npm pkg set scripts.ai:status="bash scripts/ai-status.sh"
  npm pkg set scripts.ai:precheck="bash scripts/ai-precheck.sh"
  npm pkg set scripts.daily="bash scripts/daily-flow.sh"
fi

echo "== 追加 CLAUDE.md 规则 =="

if [ -f CLAUDE.md ] && ! grep -q "AI 日常流程" CLAUDE.md; then
  cat >> CLAUDE.md <<'EOT'

## AI 日常流程

本项目使用 `ai/` 目录管理 Claude + DeepSeek 自动化任务。

### 任务流

1. 手机端或电脑端把任务写入 `ai/tasks/inbox/`。
2. AI 读取任务单。
3. AI 根据任务类型处理文章、草稿、目录或报告。
4. AI 生成报告到 `ai/reports/`。
5. AI 运行 `./scripts/check-privacy.sh`。
6. AI 运行 `npm run build`。
7. AI 运行 `git status`。
8. 用户确认后再 commit / push。

### 默认禁止

- 不读取 `_private/`
- 不提交 `private/` 或 `_private/`
- 不擅自公开 drafts
- 不擅自加入 SUMMARY.md
- 不自动 push

### 常用命令

- `./scripts/ai-new-task.sh polish "任务标题"`
- `./scripts/ai-status.sh`
- `./scripts/ai-precheck.sh`
- `./scripts/daily-flow.sh`
EOT
fi

echo "== AI 工作流补全完成 =="
