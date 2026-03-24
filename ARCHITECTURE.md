# 架构

本仓库采用显式分层结构与机械强制执行的依赖规则。

## 核心目标
- 可预期的系统结构
- Agent 高可读性
- 低架构漂移
- 快速小范围交付

## 标准分层顺序
类型层 → 配置层 → 数据层 → 服务层 → 运行时层 → UI 层

## 详细来源
参见：
- `docs/architecture/index.md`
- `docs/architecture/layering.md`
- `docs/architecture/dependency-rules.md`
