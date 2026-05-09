---
name: observability-first-debugging
description: Debug from logs, traces, metrics, screenshots, and reproducible signals before guessing. Use when investigating failures, flaky behavior, or production-like issues.
argument-hint: Describe the failure, the current signal, and which logs, metrics, or repro steps are available.
---

# Observability First Debugging

Use this skill when the next useful move is to improve signal quality, not to speculate faster.

## Workflow

1. Reproduce the issue.
2. Capture logs, traces, screenshots, or other direct signals.
3. Identify the failing boundary or domain.
4. Connect the symptom to the relevant code path.
5. Form a hypothesis.
6. Apply the smallest fix.
7. Validate using the same signal.

## Evidence

- relevant logs or traces
- before/after metrics when applicable
- explicit repro steps