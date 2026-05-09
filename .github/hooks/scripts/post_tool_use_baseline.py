from __future__ import annotations

from hook_common import (
    emit_json,
    extract_paths,
    is_validation_tool,
    is_write_tool,
    load_state,
    read_payload,
    repo_root,
    save_state,
    tool_input,
    tool_name,
    tool_response_text,
    validation_descriptor,
    write_requires_validation,
    validation_succeeded,
)


def block(reason: str, additional_context: str) -> None:
    emit_json(
        {
            "decision": "block",
            "reason": reason,
            "hookSpecificOutput": {
                "hookEventName": "PostToolUse",
                "additionalContext": additional_context,
            },
        }
    )


def format_paths(paths: list[str]) -> str:
    if not paths:
        return "recent file changes"
    return ", ".join(paths[:3])


def main() -> int:
    payload = read_payload()
    state = load_state(payload)
    name = tool_name(payload)
    parsed_input = tool_input(payload)
    response_text = tool_response_text(payload)

    if is_write_tool(name, parsed_input):
        root = repo_root(payload)
        raw_paths = extract_paths(parsed_input)
        normalized_paths = []
        for raw_path in raw_paths:
            try:
                normalized_paths.append(str((root / raw_path).resolve().relative_to(root)).replace("\\", "/"))
            except Exception:
                normalized_paths.append(raw_path.replace("\\", "/"))

        requires_validation = write_requires_validation(payload, parsed_input)
        if requires_validation:
            state["pendingValidation"] = True
            state["lastWriteTool"] = {
                "tool": name,
                "paths": normalized_paths,
                "timestamp": payload.get("timestamp"),
                "requiresValidation": True,
            }
        else:
            state["lastNonValidationWrite"] = {
                "tool": name,
                "paths": normalized_paths,
                "timestamp": payload.get("timestamp"),
            }

    if is_validation_tool(name, parsed_input):
        descriptor = validation_descriptor(name, parsed_input)
        if validation_succeeded(payload, name, response_text):
            state["pendingValidation"] = False
            state["consecutiveValidationFailures"] = 0
            state["lastFailedValidation"] = ""
            state["lastValidation"] = {
                "descriptor": descriptor,
                "status": "passed",
                "timestamp": payload.get("timestamp"),
            }
        else:
            same_validation = descriptor == state.get("lastFailedValidation")
            state["pendingValidation"] = True
            state["consecutiveValidationFailures"] = (
                int(state.get("consecutiveValidationFailures", 0)) + 1
                if same_validation
                else 1
            )
            state["lastFailedValidation"] = descriptor
            state["lastValidation"] = {
                "descriptor": descriptor,
                "status": "failed",
                "timestamp": payload.get("timestamp"),
            }
            save_state(payload, state)
            block(
                "Validation failed for the current slice.",
                "Fix the current validation failure before moving to the next slice or finishing the session.",
            )
            return 0

    save_state(payload, state)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())