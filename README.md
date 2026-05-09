# Agent 开发最佳实践模板仓库

本仓库是一套面向 **Agent 优先软件开发**的完整模板，基于以下核心理念：

> 人类掌舵，Agent 执行。仓库即系统的知识来源。用约束、反馈与闭环提升自治度。

## 为什么需要这套模板？

在 AI 辅助开发中，常见问题：
- Agent 输出不稳定、难以预期
- 工作结果脱离整体架构
- 知识散落在对话里，无法沉淀
- 任务反复失败，没有系统性改善

这套模板通过结构化入口、Skills 行为规范、Templates 执行表单和可选 CI 约束，帮助团队构建一套"Agent 操作系统"。

## 目录结构说明

```text
repo/
├── AGENTS.md              # Agent 总入口（必读）
├── ARCHITECTURE.md        # 架构速查
├── RELIABILITY.md         # 可靠性要求速查
│
├── docs/                  # 结构化知识源
│   ├── design-docs/       # 设计文档
│   ├── standards/         # 开发规范
│   ├── exec-plans/        # 执行计划
│   └── index.md           # 文档入口
│
├── .github/skills/        # GitHub Skills
├── templates/             # 可复用执行表单
└── .github/               # GitHub 模板与 CI
```

## 如何开始

- 开始具体任务前先阅读 `AGENTS.md`。默认阅读顺序、Skills 加载规则和完成定义以该文件为准。
- 按主题深入时，从 `docs/index.md` 与 `.github/skills/` 进入对应内容。
- `ARCHITECTURE.md` 与 `RELIABILITY.md` 是根目录主题速查；更细的约束和执行上下文以下钻到 `docs/` 与 active plans 为准。
