# overlays/python-project/

Python 项目类型的追加内容。

> **本 README 不会被同步到下游项目。** 同步时会自动排除（见 manifest `exclude` 字段）。

## 目录结构

```text
overlays/python-project/
├── README.md               ← 本文件（overlay 说明，不同步）
├── skills/
│   └── python-conventions.md   ← 同步到项目的 skills/
└── docs/
    └── standards/
        └── python-testing.md   ← 同步到项目的 docs/standards/
```

内容组织方式：**以下游项目根目录为基准的相对路径**。目录中的文件通过 `soft-sync` 模式追加到项目中，不会删除项目已有文件。

## 适用范围

- Python 后端服务
- Python CLI 工具
- Python 数据处理脚本

## 启用方式

在 `tools/agent-template/sync-template.config.json` 中指定：

```json
{
  "overlays": ["overlay-python"]
}
```

然后运行同步脚本：

```bash
./tools/agent-template/sync-template.sh
```

或手动指定 group：

```bash
./tools/agent-template/sync-template.sh --group overlay-python
```
