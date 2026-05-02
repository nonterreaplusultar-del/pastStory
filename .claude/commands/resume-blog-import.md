# resume-blog-import

继续执行 pastStory 项目的个人博客迁移任务。

## 核心原则

这是中断恢复任务，不要从头无脑重做，不要覆盖已有文件。

## 原始博客

- 首页：https://jerrylove.qzz.io/
- 归档页：https://jerrylove.qzz.io/archives/

## 恢复步骤

1. 运行 `git status`。
2. 检查 `drafts/blog-import/` 下已有文章。
3. 检查 `ai/reports/blog-import-manifest.md` 是否存在。
4. 检查 `ai/tasks/inbox/blog-import-plan.md` 是否存在。
5. 根据已有文件判断迁移进度。
6. 从未完成文章继续，每批最多处理 5 篇。

## 输出规则

默认输出到：

`drafts/blog-import/年份/`

不要直接移动到年份目录。

不要更新 `SUMMARY.md`，除非用户明确要求发布。

## 每篇文章格式

每篇文章必须包含：

- 来源
- 原文链接
- 原发布时间
- 迁移状态
- 公开等级
- 原文核心
- 改写后的正文
- 迁移备注

## 状态规则

manifest 中状态只能使用：

- 待抓取
- 已抓取
- 已生成草稿
- 需人工确认
- 不建议公开
- 失败

## 禁止事项

- 不读取 `_private/`
- 不修改 `_private/`
- 不提交 `private/` 或 `_private/`
- 不把草稿直接加入 `SUMMARY.md`
- 不自动 push
- 不虚构经历
- 不覆盖已有草稿

## 完成后必须运行

- `./scripts/check-privacy.sh`
- `npm run build`
- `git status`

## 报告

生成：

`ai/reports/blog-import-resume-report.md`

报告必须说明：

1. 本次恢复前已有多少篇草稿
2. 本次新处理了多少篇
3. 哪些文章处理成功
4. 哪些文章失败
5. 哪些文章需要人工确认
6. 下一批应该从哪一篇继续
