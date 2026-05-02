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
