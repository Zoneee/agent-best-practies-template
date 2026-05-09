from __future__ import annotations

import json
import re
import sys
from pathlib import Path
from typing import Any


DESTRUCTIVE_COMMAND_PATTERNS = [
    re.compile(pattern, re.IGNORECASE)
    for pattern in [
        r"(^|\s)rm\s+-rf(\s|$)",
        r"(^|\s)git\s+reset\s+--hard(\s|$)",
        r"(^|\s)git\s+checkout\s+--(\s|$)",
        r"(^|\s)git\s+clean\s+-fd",
        r"(^|\s)mkfs(\.|\s|$)",
        r"(^|\s)dd\s+if=",
        r"(^|\s)shutdown(\s|$)",
        r"(^|\s)reboot(\s|$)",
        r"(^|\s)poweroff(\s|$)",
        r"(^|\s)drop\s+table(\s|$)",
    ]
]

TERMINAL_TOOL_HINTS = (
    "terminal",
    "shell",
    "bash",
    "command",
    "exec",
    "run_in_terminal",
)

WRITE_TOOL_HINTS = (
    "edit",
    "create",
    "write",
    "replace",
    "rename",
    "move",
    "delete",
    "patch",
)

VALIDATION_TOOL_HINTS = (
    "test",
    "lint",
    "check",
    "verify",
    "diagnostic",
    "problem",
)

VALIDATION_COMMAND_PATTERNS = [
    re.compile(pattern, re.IGNORECASE)
    for pattern in [
        r"(^|\s)(npm|pnpm|yarn)\s+(run\s+)?(lint|test|check)(\s|$)",
        r"(^|\s)pytest(\s|$)",
        r"(^|\s)go\s+test(\s|$)",
        r"(^|\s)cargo\s+test(\s|$)",
        r"(^|\s)ruff\s+check(\s|$)",
        r"(^|\s)mypy(\s|$)",
        r"(^|\s)bash\s+tools/scripts/check-[a-z0-9-]+\.sh(\s|$)",
    ]
]

FAILURE_TEXT_PATTERNS = [
    re.compile(pattern, re.IGNORECASE)
    for pattern in [
        r"\bfailed\b",
        r"\berror\b",
        r"\btraceback\b",
        r"\bexception\b",
        r"exit code:\s*[1-9]",
        r"needs input",
        r"timed out",
    ]
]

SUCCESS_TEXT_PATTERNS = [
    re.compile(pattern, re.IGNORECASE)
    for pattern in [
        r"no errors found",
        r"all tests passed",
        r"\bpassed\b",
        r"所有文档链接有效",
        r"需立即修复\s*0",
        r"exit code:\s*0",
        r"\bok\b",
    ]
]

NON_EXECUTION_MODES = {"plan", "ask"}


def read_payload() -> dict[str, Any]:
    raw = sys.stdin.read()
    if not raw.strip():
        return {}
    try:
        parsed = json.loads(raw)
    except json.JSONDecodeError:
        return {"_raw": raw}
    return parsed if isinstance(parsed, dict) else {"_raw": raw}


def emit_json(payload: dict[str, Any]) -> None:
    sys.stdout.write(json.dumps(payload, ensure_ascii=True, separators=(",", ":")))


def tool_name(payload: dict[str, Any]) -> str:
    for key in ("tool_name", "toolName", "tool"):
        value = payload.get(key)
        if isinstance(value, str) and value:
            return value
    return ""


def tool_input(payload: dict[str, Any]) -> dict[str, Any]:
    direct = payload.get("tool_input")
    if isinstance(direct, dict):
        return direct

    for key in ("toolArgs", "tool_args"):
        value = payload.get(key)
        if isinstance(value, dict):
            return value
        if isinstance(value, str) and value:
            try:
                parsed = json.loads(value)
            except json.JSONDecodeError:
                return {"raw": value}
            if isinstance(parsed, dict):
                return parsed
            return {"raw": value}

    return {}


def tool_response_text(payload: dict[str, Any]) -> str:
    for key in ("tool_response", "toolResponse"):
        value = payload.get(key)
        if isinstance(value, str):
            return value

    for key in ("toolResult", "tool_result"):
        value = payload.get(key)
        if isinstance(value, dict):
            for nested_key in ("textResultForLlm", "text", "message"):
                nested_value = value.get(nested_key)
                if isinstance(nested_value, str):
                    return nested_value
            return json.dumps(value, ensure_ascii=True)

    raw = payload.get("_raw")
    return raw if isinstance(raw, str) else ""


def tool_result_type(payload: dict[str, Any]) -> str:
    for key in ("toolResult", "tool_result"):
        value = payload.get(key)
        if isinstance(value, dict):
            result_type = value.get("resultType") or value.get("result_type") or value.get("type")
            if isinstance(result_type, str):
                return result_type.lower()
    return ""


def session_id(payload: dict[str, Any]) -> str:
    raw = payload.get("sessionId") or payload.get("session_id") or "default"
    safe = re.sub(r"[^A-Za-z0-9_.-]+", "-", str(raw))
    return safe or "default"


def session_mode(payload: dict[str, Any]) -> str:
    candidate_keys = (
        "chat_mode",
        "chatMode",
        "session_mode",
        "sessionMode",
        "agent_mode",
        "agentMode",
        "mode",
    )
    for key in candidate_keys:
        value = payload.get(key)
        if isinstance(value, str):
            normalized = value.strip().lower()
            if normalized in {"plan", "ask", "agent"}:
                return normalized
    return ""


def repo_root(payload: dict[str, Any]) -> Path:
    raw_cwd = payload.get("cwd")
    if isinstance(raw_cwd, str) and raw_cwd:
        return Path(raw_cwd).resolve()
    return Path.cwd().resolve()


def state_path(payload: dict[str, Any]) -> Path:
    root = repo_root(payload)
    git_dir = root / ".git"
    state_dir = git_dir / "copilot-hooks-state" if git_dir.exists() else root / ".copilot-hooks-state"
    state_dir.mkdir(parents=True, exist_ok=True)
    return state_dir / f"{session_id(payload)}.json"


def load_state(payload: dict[str, Any]) -> dict[str, Any]:
    path = state_path(payload)
    if not path.exists():
        return {
            "pendingValidation": False,
            "consecutiveValidationFailures": 0,
            "lastFailedValidation": "",
        }
    try:
        content = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return {
            "pendingValidation": False,
            "consecutiveValidationFailures": 0,
            "lastFailedValidation": "",
        }
    if isinstance(content, dict):
        return content
    return {
        "pendingValidation": False,
        "consecutiveValidationFailures": 0,
        "lastFailedValidation": "",
    }


def save_state(payload: dict[str, Any], state: dict[str, Any]) -> None:
    path = state_path(payload)
    path.write_text(json.dumps(state, ensure_ascii=True, indent=2) + "\n", encoding="utf-8")


def is_terminal_tool(name: str) -> bool:
    lowered = name.lower()
    return any(hint in lowered for hint in TERMINAL_TOOL_HINTS)


def is_write_tool(name: str, parsed_input: dict[str, Any]) -> bool:
    lowered = name.lower()
    if any(hint in lowered for hint in WRITE_TOOL_HINTS):
        return True
    if any(key in parsed_input for key in ("newCode", "content", "insert_text", "new_str", "file_text")):
        return True
    return False


def is_validation_tool(name: str, parsed_input: dict[str, Any]) -> bool:
    lowered = name.lower()
    if lowered == "get_errors":
        return False
    if any(hint in lowered for hint in VALIDATION_TOOL_HINTS):
        return True
    command = extract_command(name, parsed_input)
    return any(pattern.search(command) for pattern in VALIDATION_COMMAND_PATTERNS)


def extract_command(name: str, parsed_input: dict[str, Any]) -> str:
    parts: list[str] = []
    for key in ("command", "cmd", "shellCommand"):
        value = parsed_input.get(key)
        if isinstance(value, str) and value:
            parts.append(value)
    args = parsed_input.get("args")
    if isinstance(args, list):
        parts.extend(str(item) for item in args)
    elif isinstance(args, str) and args:
        parts.append(args)
    raw = parsed_input.get("raw")
    if isinstance(raw, str) and raw:
        parts.append(raw)
    return " ".join(part for part in parts if part).strip()


def extract_paths(parsed_input: dict[str, Any]) -> list[str]:
    results: set[str] = set()

    def key_hint_is_path_like(key_hint: str) -> bool:
        lowered = key_hint.lower()
        return lowered.endswith("path") or lowered.endswith("paths") or lowered in {
            "file",
            "files",
        }

    def walk(value: Any, key_hint: str = "") -> None:
        if isinstance(value, dict):
            for key, nested_value in value.items():
                walk(nested_value, key)
            return
        if isinstance(value, list):
            for item in value:
                walk(item, key_hint)
            return
        if isinstance(value, str) and key_hint_is_path_like(key_hint):
            results.add(value)

    walk(parsed_input)
    return sorted(results)


def normalize_path(root: Path, raw_path: str) -> str:
    path = Path(raw_path)
    if path.is_absolute():
        try:
            return str(path.resolve().relative_to(root)).replace("\\", "/")
        except ValueError:
            return str(path).replace("\\", "/")
    return str(path).replace("\\", "/")


def protected_path_hits(payload: dict[str, Any], parsed_input: dict[str, Any]) -> list[str]:
    root = repo_root(payload)
    hits: list[str] = []
    for raw_path in extract_paths(parsed_input):
        normalized = normalize_path(root, raw_path)
        if normalized == ".git" or normalized.startswith(".git/"):
            hits.append(normalized)
    return hits


def repo_relative_path(root: Path, raw_path: str) -> str | None:
    path = Path(raw_path)
    if path.is_absolute():
        try:
            return str(path.resolve().relative_to(root)).replace("\\", "/")
        except ValueError:
            return None
    return str(path).replace("\\", "/")


def path_requires_validation(root: Path, raw_path: str) -> bool:
    relative_path = repo_relative_path(root, raw_path)
    if relative_path is None:
        return False
    return relative_path != ".git" and not relative_path.startswith(".git/")


def write_requires_validation(payload: dict[str, Any], parsed_input: dict[str, Any]) -> bool:
    if session_mode(payload) in NON_EXECUTION_MODES:
        return False

    raw_paths = extract_paths(parsed_input)
    if not raw_paths:
        return True

    root = repo_root(payload)
    return any(path_requires_validation(root, raw_path) for raw_path in raw_paths)


def recorded_write_requires_validation(payload: dict[str, Any], state: dict[str, Any]) -> bool:
    if session_mode(payload) in NON_EXECUTION_MODES:
        return False

    last_write = state.get("lastWriteTool")
    if not isinstance(last_write, dict):
        return False

    if last_write.get("tool") == "memory":
        return False

    explicit = last_write.get("requiresValidation")
    if isinstance(explicit, bool):
        return explicit

    paths = last_write.get("paths")
    if not isinstance(paths, list):
        return True
    if not paths:
        return True

    root = repo_root(payload)
    return any(isinstance(path, str) and path_requires_validation(root, path) for path in paths)


def destructive_command(command: str) -> str | None:
    for pattern in DESTRUCTIVE_COMMAND_PATTERNS:
        match = pattern.search(command)
        if match:
            return match.group(0).strip()
    return None


def validation_descriptor(name: str, parsed_input: dict[str, Any]) -> str:
    command = extract_command(name, parsed_input)
    if command:
        compact = re.sub(r"\s+", " ", command).strip()
        return f"{name}:{compact}"[:240]
    return name[:240]


def validation_succeeded(payload: dict[str, Any], name: str, response_text: str) -> bool:
    lowered_response = response_text.lower()
    if any(pattern.search(lowered_response) for pattern in SUCCESS_TEXT_PATTERNS):
        return True

    result_type = tool_result_type(payload)
    if result_type == "failure":
        return False

    if "error" in name.lower():
        return False

    if any(pattern.search(lowered_response) for pattern in FAILURE_TEXT_PATTERNS):
        return False

    return result_type == "success"