# project-audit

你现在担任 pastStory 项目的“长期维护审计员”和“GitBook 阅读体验优化顾问”。

这是一个长任务，目标不是继续迁移文章，而是在博客迁移基本完成后，对整个项目做一次系统体检，找出还有哪些地方可以做得更好，以便以后更好维护、阅读、更新、手机端修改、AI 自动化处理。

## 绝对禁止

- 不读取 `_private/`
- 不读取 `private/`
- 不修改 `_private/`
- 不修改 `private/`
- 不删除任何文章
- 不大规模移动文章
- 不自动重写文章正文
- 不自动 commit
- 不自动 push
- 不擅自公开 drafts
- 不擅自修改 SUMMARY.md

## 必须生成的报告

- `ai/reports/project-audit-progress.md`
- `ai/reports/project-audit-overview.md`
- `ai/reports/project-audit-structure.md`
- `ai/reports/project-audit-gitbook.md`
- `ai/reports/project-audit-content.md`
- `ai/reports/project-audit-images.md`
- `ai/reports/project-audit-ai-workflow.md`
- `ai/reports/project-audit-maintenance-roadmap.md`
- `ai/tasks/inbox/project-maintenance-roadmap.md`

## 审计范围

检查：

1. 项目结构
2. 年份目录
3. 文件命名
4. README.md
5. SUMMARY.md
6. GitBook 构建
7. 文章可读性
8. 图片资源
9. AI 工作流
10. scripts 脚本
11. 隐私保护
12. 手机端维护流程
13. 后续维护路线图

## 严重程度标准

P0：隐私泄露、构建失败、数据丢失  
P1：GitBook 展示混乱、目录错误、维护困难  
P2：影响阅读体验或长期维护  
P3：风格优化、命名优化、可做可不做  

## 执行方式

每完成一个阶段，都更新：

`ai/reports/project-audit-progress.md`

不要把所有工作堆到最后。

## 最后必须运行

- `./scripts/check-privacy.sh`
- `npm run build`
- `git status --short`

## 最终回复

只输出摘要：

1. 总体评分
2. P0 问题数量
3. P1 问题数量
4. 推荐立即处理的 5 件事
5. 生成了哪些报告文件
6. 下一步建议
