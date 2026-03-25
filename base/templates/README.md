# base/templates/

本目录镜像 `templates/` 的内容，作为同步脚本的 **源路径（source）**。

下游项目同步后，`templates/` 会出现在项目根目录下，供 Agent 填写和复用。

## 当前状态

Phase 1 阶段，`base/templates/` 与根目录 `templates/` 保持内容一致，以 `manifest/template-manifest.json` 中的 `source` 路径为准。

## 包含的模板

| 文件 | 用途 |
|------|------|
| `plan-template.md` | 执行计划（质量前置结构） |
| `pr-template.md` | PR 提交模板 |
| `bug-report-template.md` | 缺陷报告模板 |
| `feature-spec-template.md` | 功能规格模板 |
| `design-doc-template.md` | 设计文档模板 |
| `cleanup-report-template.md` | 清理报告模板 |

## 同步模式

**强同步（hard-sync）**：下游项目不应覆盖这些文件，以保持跨项目模板一致性。
