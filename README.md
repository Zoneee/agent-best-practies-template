# Agent 开发最佳实践模板仓库

本仓库是一套面向 **Agent 优先软件开发**的完整模板，基于以下核心理念：

> 人类掌舵，Agent 执行。仓库即系统的知识来源。用约束、反馈与闭环提升自治度。

## 为什么需要这套模板？

在 AI 辅助开发中，常见问题：
- Agent 输出不稳定、难以预期
- 工作结果脱离整体架构
- 知识散落在对话里，无法沉淀
- 任务反复失败，没有系统性改善

这套模板通过结构化的文档体系、Skills 行为规范、Templates 执行表单和 CI 约束，帮助团队构建一套"Agent 操作系统"。

## 目录结构说明

```text
repo/
├── AGENTS.md              # Agent 总入口（必读）
├── ARCHITECTURE.md        # 架构速查
├── DESIGN.md              # 设计原则速查
├── PRODUCT_SENSE.md       # 产品直觉速查
├── QUALITY_SCORE.md       # 质量评分
├── RELIABILITY.md         # 可靠性要求速查
├── SECURITY.md            # 安全要求速查
│
├── docs/                  # 结构化知识源
│   ├── architecture/      # 架构文档
│   ├── design-docs/       # 设计文档
│   ├── product-specs/     # 产品规格
│   ├── standards/         # 开发规范
│   ├── runbooks/          # 运行手册
│   ├── exec-plans/        # 执行计划
│   ├── generated/         # 自动生成文档
│   └── references/        # 外部参考
│
├── skills/                # Agent 行为手册
├── templates/             # 可复用执行表单
├── .github/               # GitHub 模板与 CI
└── tools/                 # 脚本与 lint 工具
```

## 如何开始

- 开始具体任务前先阅读 `AGENTS.md`。默认阅读顺序、Skills 加载规则和完成定义以该文件为准。
- 按主题深入时，从 `docs/index.md` 与 `skills/index.md` 进入对应内容。
- `ARCHITECTURE.md`、`DESIGN.md`、`PRODUCT_SENSE.md`、`RELIABILITY.md`、`SECURITY.md` 是根目录主题速查；`QUALITY_SCORE.md` 是按需查看的全局状态参考。
