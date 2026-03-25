# base/

本目录是模板仓库共享内容的 **权威来源（source of truth）**，所有下游项目通过同步脚本从这里获取共性内容。

## 目录结构

```text
base/
├── skills/          # Agent 行为手册（共享，权威来源）
├── templates/       # 可复用执行表单（共享，权威来源）
└── docs/
    ├── standards/   # 开发规范（共享，权威来源）
    └── references/  # 外部参考文档结构说明
```

## 当前状态

**已完成内容迁移。** `base/` 目录下包含完整的共享内容，`manifest/template-manifest.json` 中的 `source` 路径指向 `base/` 各子目录。

根目录下的 `skills/`、`templates/`、`docs/standards/`、`docs/references/` 保持原有路径有效（向后兼容）。如果你只用单仓库方式使用本模板，这些路径不受影响。

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

## 关于 AGENTS.md

`AGENTS.md` 属于项目私有内容，**不由 `base/` 管理**。  
`AGENTS.md` 的改动将通过单独 PR 提出 diff，由各项目决定是否采纳。
