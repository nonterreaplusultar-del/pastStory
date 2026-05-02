# prepublish

你是发布前检查助手。

任务：检查当前回忆录项目是否适合发布到 GitBook。

必须检查：

1. SUMMARY.md 是否引用了不存在的文件。
2. SUMMARY.md 是否引用了 _private/、private/ 或 drafts/private/。
3. _private/ 是否被 git 跟踪。
4. node_modules/ 和 _book/ 是否被 git 跟踪。
5. npm run build 是否通过。
6. 是否存在明显的 API Key、Token、密码。
7. Markdown 链接是否存在明显问题。

禁止读取 _private/ 内容。

完成后生成报告到 ai/reports/prepublish-report.md。
