# base/docs/standards/

本目录是开发规范文档的 **权威来源（source of truth）**，作为同步脚本的源路径。

下游项目同步后，这些文件会出现在项目的 `docs/standards/` 下，供开发规范查阅。

## 当前状态

**已完成内容迁移。** `base/docs/standards/` 包含全部规范文件，`manifest/template-manifest.json` 中的 `source` 路径指向此目录（`base/docs/standards/`）。

根目录 `docs/standards/` 保持原有路径有效，以确保向后兼容。

## 包含的规范

| 文件 | 用途 |
|------|------|
| `index.md` | 规范总索引 |
| `coding-rules.md` | 编码规则 |
| `naming.md` | 命名规范 |
| `testing-rules.md` | 测试规则 |
| `api-contracts.md` | API 契约规范 |
| `logging.md` | 日志规范 |
| `security.md` | 安全规范 |
| `reliability.md` | 可靠性规范 |
| `schema-validation.md` | Schema 校验规范 |
| `file-size-limits.md` | 文件大小限制 |

## 同步模式

**弱同步（soft-sync）**：下游项目允许在本地 `docs/standards/` 中追加项目特有规范文件，同步时不会删除本地新增内容，但会覆盖与模板同名的文件。
