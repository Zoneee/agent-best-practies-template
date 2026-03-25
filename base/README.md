# base/

本目录是模板仓库共享内容的 **权威来源（source of truth）**，所有下游项目通过同步脚本从这里获取共性内容。

## 目录结构

```text
base/
├── skills/          # Agent 行为手册（共享）
├── templates/       # 可复用执行表单（共享）
└── docs/
    ├── standards/   # 开发规范（共享）
    └── references/  # 外部参考文档（共享）
```

## 设计原则

- `base/` 中的内容适合所有项目类型共享，不包含项目私有的架构或业务逻辑。
- 下游项目通过 `tools/agent-template/sync-template.sh` 从 `base/` 同步内容。
- 项目私有内容（`AGENTS.md`、`ARCHITECTURE.md`、`README.md` 等）不由 `base/` 管理。

## 内容分类

| 内容 | 同步模式 | 说明 |
|------|---------|------|
| `skills/` | 强同步（hard-sync）| 行为规范需要保持一致 |
| `templates/` | 强同步（hard-sync）| 模板格式需要统一 |
| `docs/standards/` | 弱同步（soft-sync）| 允许项目在本地扩展 |
| `docs/references/` | 弱同步（soft-sync）| 允许项目添加私有参考文档 |

## 向后兼容说明

当前阶段（Phase 1），根目录下的 `skills/`、`templates/`、`docs/standards/`、`docs/references/` 与 `base/` 中的内容保持同步，两条路径均有效。

**迁移计划：**
- Phase 2：将根目录下的共享内容移动至 `base/`，通过同步脚本分发到下游项目
- Phase 3：根目录仅保留模板仓库本身使用的入口文件（`AGENTS.md`、`README.md` 等）

`AGENTS.md` 的路径调整将通过单独 PR 提出 diff，由人工决定是否采用。
