---
name: boundary-validation
description: Validate untrusted input at system boundaries. Use when changing payloads, query params, env vars, external APIs, webhooks, uploads, browser storage, or any shape-uncertain data.
argument-hint: Describe the boundary, the input shape, and how invalid input should be rejected or normalized.
---

# Boundary Validation

Use this skill when a task crosses a trust boundary and raw data must be parsed before it reaches business logic.

## Rules

1. Parse and validate at the boundary.
2. Do not pass shape-unknown data into core logic.
3. Return explicit validation failures.
4. Prefer strong internal representations after validation.
5. Add or update tests for both valid and invalid cases.
6. Record new contract expectations in surviving standards docs, active plans, or companion notes when needed.

## Typical boundaries

- request payloads and query params
- environment variables
- external APIs and webhooks
- uploads and browser storage
- shape-uncertain database reads or third-party responses

## Minimum evidence

- success-path validation coverage
- failure-path validation coverage
- a clear note describing where validation happens