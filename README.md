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
├── AGENTS.md              # Agent 总入口（必读，项目本地维护）
├── ARCHITECTURE.md        # 架构速查
├── DESIGN.md              # 设计原则速查
├── PRODUCT_SENSE.md       # 产品直觉速查
├── QUALITY_SCORE.md       # 质量评分
├── RELIABILITY.md         # 可靠性要求速查
├── SECURITY.md            # 安全要求速查
├── CHANGELOG.md           # 版本化发布说明
│
├── base/                  # 共享内容权威来源（同步脚本的 source）
│   ├── skills/            # Agent 行为手册结构说明
│   ├── templates/         # 模板结构说明
│   └── docs/
│       ├── standards/     # 开发规范结构说明
│       └── references/    # 外部参考结构说明
│
├── overlays/              # 项目类型专用追加内容
│   ├── python-project/    # Python 项目 overlay
│   └── node-project/      # Node.js 项目 overlay
│
├── examples/              # 示例项目结构
│   └── simple-project/    # 最简单的单语言项目示例
│
├── manifest/
│   └── template-manifest.json  # 同步清单（定义 group/source/target/mode）
│
├── docs/                  # 结构化知识源
│   ├── architecture/      # 架构文档
│   ├── design-docs/       # 设计文档
│   ├── product-specs/     # 产品规格
│   ├── standards/         # 开发规范（与 base/docs/standards/ 保持同步）
│   ├── runbooks/          # 运行手册
│   ├── exec-plans/        # 执行计划
│   ├── generated/         # 自动生成文档
│   └── references/        # 外部参考（与 base/docs/references/ 保持同步）
│
├── skills/                # Agent 行为手册（与 base/skills/ 保持同步）
├── templates/             # 可复用执行表单（与 base/templates/ 保持同步）
├── .github/               # GitHub 模板与 CI
└── tools/
    ├── agent-template/    # 模板同步工具
    │   ├── sync-template.sh          # 主同步脚本
    │   ├── sync-template.config.json # 本地配置示例
    │   └── template-version.json     # 同步版本追踪
    └── ...                # 其他脚本与 lint 工具
```

## 多项目复用架构（base / overlays / examples）

### 为什么引入这套结构？

随着越来越多的项目需要复用同一套 Agent 工作规范，手动复制文件的方式会导致：
- 规范内容在各项目中逐渐漂移，失去一致性
- 模板更新后，下游项目难以追踪变更和选择性采纳
- 无法区分哪些内容是"所有项目共享"，哪些是"项目类型专属"，哪些是"项目私有"

`base/overlays/examples` 三层结构解决这个问题：

| 层级 | 路径 | 用途 |
|------|------|------|
| **base** | `base/` | 所有项目可共享的共性内容（skills、templates、standards 等） |
| **overlay** | `overlays/<type>/` | 特定项目类型的可选追加内容（Python 专属规范、Node.js 专属规范等） |
| **examples** | `examples/` | 示例项目结构，说明同步后推荐的目录布局 |

### manifest / sync script / project config 如何协作

```text
manifest/template-manifest.json          ← 模板仓库维护
  定义：group 名称、源路径、目标路径、同步模式（hard/soft）

tools/agent-template/sync-template.config.json  ← 下游项目本地维护
  Phase 1：仅配置模板仓库来源（templateRepo / templateRepoUrl 等）
  规划能力（尚未在 sync-template.sh 中实现）：选择哪些 overlay、是否禁用某个 group

tools/agent-template/sync-template.sh    ← 执行层
  Phase 1：读取 manifest + config 中的模板仓库信息 → 克隆模板 @ ref → 通过 CLI 参数（如 --group）手动选择 overlay / group 并同步文件到项目

tools/agent-template/template-version.json  ← 自动维护
  记录：已同步的 ref、提交 SHA、时间戳
```

### 哪些内容适合强同步、弱同步、项目私有维护？

| 内容 | 同步模式 | 理由 |
|------|---------|------|
| `skills/` | **强同步（hard-sync）** | Agent 行为规范需要跨项目保持一致 |
| `templates/` | **强同步（hard-sync）** | 模板格式需要统一，避免每个项目各搞一套 |
| `docs/standards/` | **弱同步（soft-sync）** | 基础规范共享，但允许项目追加语言或框架特有规范 |
| `docs/references/` | **弱同步（soft-sync）** | 允许项目追加私有参考文档（框架版本等） |
| `AGENTS.md` | **项目私有** | 各项目 Agent 入口需要结合项目实际定制 |
| `ARCHITECTURE.md` | **项目私有** | 架构决策由项目本地维护 |
| `docs/architecture/` | **项目私有** | 完全由项目维护 |
| `docs/exec-plans/` | **项目私有** | 执行计划是项目内部文档 |

### 关于 AGENTS.md 的变更方式

**本模板仓库不会自动同步 `AGENTS.md` 到下游项目。**

- 初始化时，下游项目可以参考本仓库根目录的 `AGENTS.md` 作为起点。
- 之后，`AGENTS.md` 由各项目自行维护，体现项目的工作规则。
- 当模板仓库的 `AGENTS.md` 有重要更新时，将通过单独 PR 提出 diff，由各项目决定是否采纳。

这样做的好处是：**不同项目可以在遵守共性规范的同时，保留自己的 Agent 工作规则定制空间。**



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

### 单项目直接使用

1. 将本仓库结构复制到你的项目（或使用 GitHub "Use this template"）
2. 先阅读 `AGENTS.md`
3. 阅读 `skills/delivery-quality-first.md`，明确交付质量优先原则
4. 用 `templates/plan-template.md` 制定执行计划
5. 按 `skills/plan-before-code.md` 的流程推进
6. 参考 `docs/` 中的相关文档实现
7. 用 `templates/pr-template.md` 提交证据

### 多项目复用（推荐）

如果你有多个项目都需要复用这套模板：

1. 将本仓库作为模板仓库，各下游项目使用 `tools/agent-template/sync-template.sh` 同步
2. 参考 `examples/simple-project/README.md` 了解同步后的目录结构
3. 参考 `manifest/template-manifest.json` 了解哪些内容可同步
4. 将 `tools/agent-template/` 复制到目标项目并配置 `sync-template.config.json`
5. 运行 `./tools/agent-template/sync-template.sh --dry-run` 预览
6. 运行 `./tools/agent-template/sync-template.sh` 执行同步

详见 `tools/agent-template/README.md`。

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
