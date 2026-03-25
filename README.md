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

## 连接逻辑

```text
AGENTS.md（总入口）
  ↓
skills/index.md（场景行为导航）
  ↓
templates/task-template.md（任务定义）
  ↓
docs/（架构 + 规范 + 产品规格）
  ↓
实现最小改动
  ↓
templates/pr-template.md（提交证据）
  ↓
CI 自动检查（强制约束）
  ↓
quality / cleanup（长期治理）
```

## 快速开始

1. 将本仓库结构复制到你的项目
2. 先阅读 `AGENTS.md`
3. 阅读 `skills/delivery-quality-first.md`，明确交付质量优先原则
4. 用 `templates/task-template.md` 定义第一个任务
5. 按 `skills/plan-before-code.md` 制定计划
6. 参考 `docs/` 中的相关文档实现
7. 用 `templates/pr-template.md` 提交证据

## 多项目复用与回流

本模板支持多项目复用。下游项目可通过同步脚本（`tools/agent-template/sync-template.sh`）从本仓库拉取最新共性 Skills 和 Templates。

当下游项目在实践中积累了经过验证的共性改进时，可通过"受控回流 PR 工作流"将其贡献回本仓库：

1. 阅读 `skills/skill-upstream-pr.md`，了解回流判断流程
2. 确认改动具有通用价值且已剥离项目专属内容
3. 使用 `templates/upstream-skill-pr-template.md` 填写 PR 正文
4. 参考 `tools/scripts/propose-skill-upstream-pr-design.md` 了解辅助脚本规范
5. 向本仓库发起 Pull Request，等待维护者评审

**注意：回流是受控的人工流程，不是自动反向同步。**

## 模式使用要求

无论在哪种模式下，输出都应优先表达交付质量控制，而不是只强调修复内容。

### Plan 模式
- 先写如何保证交付质量，再写问题修复方案。
- 必须显式列出范围边界、质量门禁、验证计划、证据要求、风险与回滚。
- 若计划里"修什么"明显多于"如何安全交付"，应视为计划结构不合格。

### Agent 模式
- 执行前先声明采用了哪些 Skills，以及如何控制范围、验证结果、收集证据。
- 不得跳过质量门禁与回滚设计直接开始改动。
- 若信息不足，先补计划、文档或约束，再继续执行。

### Ask 模式
- 不只回答"建议做什么"，还要回答"如何验证建议成立"。
- 不只比较方案优劣，还要说明交付风险与适用边界。
- 若证据不足，应优先说明不确定性与下一步验证路径。

## 核心原则

**地图优先**：短小的 `AGENTS.md` + 结构化 `docs/` = 让 Agent 知道从哪里进、去哪里找、什么最重要。

**约束优先**：不写"请遵守最佳实践"，而是把规则变成分层规则、边界校验、文档更新要求、PR 证据要求、CI 检查。

**闭环优先**：要求完整的计划 → 实现 → 验证 → 证据 → 自查 → 失败恢复 → 长期清理闭环。
