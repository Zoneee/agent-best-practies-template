from __future__ import annotations

from hook_common import emit_json, load_state, read_payload, recorded_write_requires_validation, save_state


def block(reason: str) -> None:
    emit_json(
        {
            "hookSpecificOutput": {
                "hookEventName": "Stop",
                "decision": "block",
                "reason": reason,
            }
        }
    )


def main() -> int:
    payload = read_payload()
    if payload.get("stop_hook_active"):
        return 0

    state = load_state(payload)
    if state.get("pendingValidation") and not recorded_write_requires_validation(payload, state):
        state["pendingValidation"] = False
        save_state(payload, state)

    if int(state.get("consecutiveValidationFailures", 0)) >= 2:
        block(
            "The same validation failed more than once. Report the blocker or update the handoff contract before finishing."
        )
        return 0

    if state.get("pendingValidation"):
        last_write = state.get("lastWriteTool") or {}
        paths = last_write.get("paths") or []
        if paths:
            target = ", ".join(paths[:3])
            reason = f"Run and record validation after the latest edits before finishing: {target}."
        else:
            reason = "Run and record validation after the latest file changes before finishing."
        block(reason)
        return 0

    return 0


if __name__ == "__main__":
    raise SystemExit(main())