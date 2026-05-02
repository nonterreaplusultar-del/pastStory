# CLAUDE.md — pastStory 回忆录项目说明

## 项目定位

这是一个个人回忆录项目，使用 Markdown 编写，并通过 GitBook 托管展示。

AI 的角色不是作者本人，而是写作助理、整理助理和项目维护助手。

主要任务包括：

- 整理回忆录素材
- 润色 Markdown 文章
- 维护 GitBook 目录
- 检查隐私风险
- 检查构建结果
- 辅助提交前整理

## 项目结构

公开内容按年份组织：

- 2017/
- 2018/
- 2020/
- 2025/
- 2026/

辅助目录：

- images/：公开图片
- drafts/：草稿，可以提交，但默认不进入 GitBook
- _private/：绝对私密内容，禁止读取、修改、提交和引用
- templates/：文章模板
- scripts/：自动化脚本
- ai/tasks/：用户交给 AI 的任务单
- ai/reports/：AI 生成的检查报告
- SUMMARY.md：GitBook 目录
- README.md：GitBook 首页

## 绝对禁止事项

AI 不得做以下事情：

1. 不得读取、修改、总结、引用 _private/ 下的任何内容。
2. 不得把 _private/、private/、.env、CLAUDE.local.md 加入 git。
3. 不得擅自把 drafts/ 中的文章加入 SUMMARY.md。
4. 不得虚构作者经历。
5. 不得擅自公开草稿。
6. 不得删除年份目录中的原文。
7. 不得公开真实姓名、联系方式、住址、证件、聊天截图等敏感信息。
8. 不得把 API Key、Token、密码写入仓库文件。

## 写作风格

整体风格应当：

- 真诚
- 克制
- 有叙事感
- 保留作者自己的口吻
- 不要公众号腔
- 不要鸡汤
- 不要过度煽情
- 不要明显 AI 味

润色时只优化表达，不改变事实。

## GitBook 规则

SUMMARY.md 控制 GitBook 的公开目录。

修改公开内容时，需要注意：

1. 新增公开文章后，询问或检查是否需要更新 SUMMARY.md。
2. 不要重复引用同一个 Markdown 文件。
3. 不要把 _private/ 加入 SUMMARY.md。
4. 不要把 drafts/ 加入 SUMMARY.md，除非用户明确要求公开。
5. 修改后应运行检查脚本。

## 推荐检查命令

完成较大修改后，运行：

- ./scripts/check-privacy.sh
- npm run build
- git status

## 默认工作流

1. 先理解 README.md、SUMMARY.md 和相关年份目录。
2. 判断任务类型：新建、润色、整理、检查、发布。
3. 只修改和任务相关的文件。
4. 默认创建草稿，不直接覆盖原文。
5. 修改后给出变更摘要。
6. 不自动 push，除非用户明确要求。

