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

## 目录边界

- `ai/reports/`：可提交的 AI 工作报告，默认不发布到 GitBook。
- `ai/reports/private/`：私密报告，已被 `.gitignore` 忽略，不提交。
- `analysis_output/`：临时分析输出，默认不发布到 GitBook。
- 需要公开的分析文章必须由作者确认，再移动到公开年份目录并加入 `SUMMARY.md`。
