# Skills 索引

本页只负责按场景导航 Skills。默认启动顺序、必读 Skills 和加载规则以 `AGENTS.md` 为准。

## 核心 Skills
- delivery-quality-first.md：交付质量优先（所有模式的默认起点）
- plan-before-code.md：先计划，后编码
- repo-as-source-of-truth.md：仓库即唯一事实来源
- small-safe-prs.md：小而安全的 PR
- evidence-driven-delivery.md：以证据驱动交付

## 实现类 Skills
- boundary-validation.md：边界校验
- codebase-navigation.md：代码库导航
- refactor-with-constraints.md：约束性重构
- docs-update-required.md：文档必须同步更新

## 评审与恢复类 Skills
- self-review-loop.md：提交前自查循环
- failure-recovery.md：失败恢复
- fix-the-system-not-just-the-ticket.md：修系统而非只修工单
- observability-first-debugging.md：可观测性优先调试

## 维护类 Skills
- entropy-cleanup.md：熵值清理

## 按场景加载提示

- 制定计划、梳理范围或定义证据时：`delivery-quality-first`、`plan-before-code`、`repo-as-source-of-truth`
- 实现与改动控制时：`boundary-validation`、`refactor-with-constraints`、`docs-update-required`、`codebase-navigation`
- 提交前自查时：`self-review-loop`、`evidence-driven-delivery`、`small-safe-prs`
- 被阻塞、任务反复失败或质量漂移时：`failure-recovery`、`fix-the-system-not-just-the-ticket`、`entropy-cleanup`
