# base/docs/standards/

本目录镜像 `docs/standards/` 的内容，作为同步脚本的 **源路径（source）**。

下游项目同步后，`docs/standards/` 会出现在项目内，供开发规范查阅。

## 当前状态

Phase 1 阶段，`base/docs/standards/` 与根目录 `docs/standards/` 保持内容一致，以 `manifest/template-manifest.json` 中的 `source` 路径为准。

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
