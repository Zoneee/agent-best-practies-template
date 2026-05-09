---
name: failure-recovery
description: Recover when execution is stuck, looping, or repeatedly failing. Use when tests or builds keep failing, the root cause is unclear, or the current approach is not converging.
argument-hint: Describe the failure, the repeated symptom, what has already been tried, and the narrowest reproducible signal you have.
---

# Failure Recovery

Use this skill when continued implementation without a reset would only widen the blast radius.

## Recovery flow

1. Stop expanding scope.
2. Record the current hypothesis.
3. Reduce to the smallest reproducible case.
4. Inspect logs, traces, screenshots, or command output.
5. Classify the failure: code bug, missing context, missing tool support, unstable environment, or invalid hypothesis.
6. Apply the smallest corrective change.
7. If the same class of failure keeps recurring, trigger `fix-the-system-not-just-the-ticket`.

## Do not

- blindly retry
- keep adding code before narrowing the failure
- treat repeated friction as a one-off forever