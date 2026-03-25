# overlays/node-project/

Node.js 项目类型的追加内容。

> **本 README 不会被同步到下游项目。** 同步时会自动排除（见 manifest `exclude` 字段）。

## 目录结构

```text
overlays/node-project/
├── README.md               ← 本文件（overlay 说明，不同步）
├── skills/
│   └── node-conventions.md     ← 同步到项目的 skills/
└── docs/
    └── standards/
        └── node-testing.md     ← 同步到项目的 docs/standards/
```

内容组织方式：**以下游项目根目录为基准的相对路径**。目录中的文件通过 `soft-sync` 模式追加到项目中，不会删除项目已有文件。

## 适用范围

- Node.js 后端服务（Express、NestJS 等）
- 前端 React/Vue/Angular 项目
- Node.js CLI 工具

## 启用方式

在 `tools/agent-template/sync-template.config.json` 中指定：

```json
{
  "overlays": ["overlay-node"]
}
```

然后运行同步脚本：

```bash
./tools/agent-template/sync-template.sh
```

或手动指定 group：

```bash
./tools/agent-template/sync-template.sh --group overlay-node
```
