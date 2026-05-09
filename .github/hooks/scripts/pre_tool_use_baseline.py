from __future__ import annotations

from hook_common import (
    destructive_command,
    emit_json,
    is_terminal_tool,
    is_write_tool,
    protected_path_hits,
    read_payload,
    tool_input,
    tool_name,
)


def deny(reason: str) -> None:
    emit_json(
        {
            "hookSpecificOutput": {
                "hookEventName": "PreToolUse",
                "permissionDecision": "deny",
                "permissionDecisionReason": reason,
            }
        }
    )


def main() -> int:
    payload = read_payload()
    name = tool_name(payload)
    parsed_input = tool_input(payload)

    if is_terminal_tool(name):
        command = parsed_input.get("command") or parsed_input.get("raw") or ""
        if isinstance(command, str):
            matched = destructive_command(command)
            if matched:
                deny(f"Blocked destructive terminal command pattern: {matched}")
                return 0

    hits = protected_path_hits(payload, parsed_input)
    if hits and is_write_tool(name, parsed_input):
        deny(
            "Blocked write into protected repository metadata paths: " + ", ".join(hits[:5])
        )
        return 0

    return 0


if __name__ == "__main__":
    raise SystemExit(main())