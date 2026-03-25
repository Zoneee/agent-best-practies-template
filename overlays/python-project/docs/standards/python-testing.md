# Python 测试规范

> 本文件由 `overlay-python` 追加到项目的 `docs/standards/` 目录。

## 框架

- 使用 `pytest` 作为测试框架
- 使用 `pytest-cov` 收集覆盖率
- 使用 `pytest-mock` 处理 Mock

## 覆盖率要求

- 最低行覆盖率：80%
- 核心业务逻辑最低行覆盖率：90%

## 测试组织

```text
tests/
├── unit/          # 单元测试
├── integration/   # 集成测试
└── conftest.py    # 公共 fixtures
```

## 命名规范

- 测试文件：`test_<module>.py`
- 测试函数：`test_<功能描述>`
- Fixture 文件：`conftest.py`

## CI 命令

```bash
pytest --cov=src --cov-report=term-missing
```
