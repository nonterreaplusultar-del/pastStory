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
