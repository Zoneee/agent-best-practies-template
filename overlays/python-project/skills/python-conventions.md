# python-conventions

> 本文件由 `overlay-python` 追加到项目的 `skills/` 目录。

## 目的

为 Python 项目补充语言特定的 Agent 行为约定，与 `base/skills/` 中的通用 Skills 配合使用。

## 编码约定

- 遵循 [PEP 8](https://peps.python.org/pep-0008/) 代码风格
- 类型提示：所有公共函数必须有类型注解（Python 3.9+）
- docstring：使用 Google 风格 docstring

## 工具链

- 格式化：`black` + `isort`
- 类型检查：`mypy --strict`
- Lint：`ruff`
- 测试：`pytest` + `pytest-cov`

## Agent 行为要求

- 修改 Python 代码时必须同步检查类型注解完整性
- 添加新函数时必须补充 docstring
- 运行 `pytest` 验证测试通过，`mypy` 验证类型无误
