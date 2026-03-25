# base/docs/references/

本目录镜像 `docs/references/` 的内容，作为同步脚本的 **源路径（source）**。

下游项目同步后，`docs/references/` 会出现在项目内，供 Agent 查阅外部参考文档。

## 当前状态

Phase 1 阶段，`base/docs/references/` 与根目录 `docs/references/` 保持内容一致，以 `manifest/template-manifest.json` 中的 `source` 路径为准。

## 说明

`docs/references/` 目录用于存放 llms.txt 格式或 Markdown 格式的外部参考文档（框架、基础设施、UI 库等的精简参考），减少 Agent 在无文档情况下的猜测行为。

## 同步模式

**弱同步（soft-sync）**：下游项目允许在本地追加项目专有参考文档，同步时不会删除本地新增内容。
