# base/templates/

本目录是可复用执行表单（Templates）的 **权威来源（source of truth）**，作为同步脚本的源路径。

下游项目同步后，这些文件会出现在项目根目录的 `templates/` 下，供 Agent 填写和复用。

## 当前状态

**已完成内容迁移。** `base/templates/` 包含全部模板文件，`manifest/template-manifest.json` 中的 `source` 路径指向此目录（`base/templates/`）。

根目录 `templates/` 保持原有路径有效，以确保向后兼容。

## 包含的模板

| 文件 | 用途 |
|------|------|
| `plan-template.md` | 执行计划（质量前置结构） |
| `pr-template.md` | PR 提交模板 |
| `bug-report-template.md` | 缺陷报告模板 |
| `feature-spec-template.md` | 功能规格模板 |
| `design-doc-template.md` | 设计文档模板 |
| `cleanup-report-template.md` | 清理报告模板 |
| `runbook-template.md` | 运行手册模板 |
| `task-template.md` | 任务定义模板 |

## 同步模式

**强同步（hard-sync）**：下游项目不应覆盖这些文件，以保持跨项目模板一致性。
