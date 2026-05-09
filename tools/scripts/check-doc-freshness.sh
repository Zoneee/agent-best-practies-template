#!/usr/bin/env bash
# 检查模板仓库中哪些文档需要真实评审日期，哪些允许保留占位值
# 用法：bash tools/scripts/check-doc-freshness.sh

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
MISSING_FIELD=0
PLACEHOLDER_VALUE=0
STRICT_SCOPE=0
PLACEHOLDER_SCOPE=0
SKIPPED_SCOPE=0

should_skip_file() {
  local file="$1"

  case "$file" in
    "$REPO_ROOT"/docs/exec-plans/active/*.md) return 0 ;;
    "$REPO_ROOT"/docs/exec-plans/completed/*.md) return 0 ;;
    "$REPO_ROOT"/docs/exec-plans/tech-debt-tracker.md) return 0 ;;
  esac

  return 1
}

allows_placeholder_review() {
  local file="$1"

  case "$file" in
    "$REPO_ROOT"/docs/architecture/*.md) return 0 ;;
    "$REPO_ROOT"/docs/design-docs/*.md) return 0 ;;
    "$REPO_ROOT"/docs/product-specs/*.md) return 0 ;;
    "$REPO_ROOT"/docs/runbooks/*.md) return 0 ;;
    "$REPO_ROOT"/docs/standards/*.md) return 0 ;;
  esac

  return 1
}

echo "正在检查文档新鲜度..."
echo "当前仓库按三类处理：严格检查、保留占位、排除自动检查"
echo "当前自动检查覆盖：缺少“最后评审”字段、严格检查范围内仍为占位值"
echo "当前仍需人工检查：重复/噪音控制、过时内容清理"
echo "当前脚本默认仅输出告警统计，不因发现问题而失败退出"

while IFS= read -r -d '' file; do
  if should_skip_file "$file"; then
    SKIPPED_SCOPE=$((SKIPPED_SCOPE + 1))
    continue
  fi

  review_line="$(grep -m1 -E '^最后评审[:：]' "$file" 2>/dev/null || true)"

  if allows_placeholder_review "$file"; then
    PLACEHOLDER_SCOPE=$((PLACEHOLDER_SCOPE + 1))

    if [[ -z "$review_line" ]]; then
      echo "⚠️  模板文档缺少最后评审字段：$file"
      MISSING_FIELD=$((MISSING_FIELD + 1))
    fi

    continue
  fi

  STRICT_SCOPE=$((STRICT_SCOPE + 1))

  if [[ -z "$review_line" ]]; then
    echo "⚠️  缺少最后评审字段：$file"
    MISSING_FIELD=$((MISSING_FIELD + 1))
    continue
  fi

  if [[ "$review_line" =~ 填写日期|待补充|TBD ]] || [[ "$review_line" =~ ^最后评审[:：][[:space:]]*$ ]]; then
    echo "⚠️  严格检查文档的最后评审仍为占位值：$file -> $review_line"
    PLACEHOLDER_VALUE=$((PLACEHOLDER_VALUE + 1))
  fi
done < <(find "$REPO_ROOT/docs" -name "*.md" -print0 | sort -z)

TOTAL_WARNINGS=$((MISSING_FIELD + PLACEHOLDER_VALUE))

echo "文档新鲜度检查完成"
echo "- 严格检查文档：$STRICT_SCOPE"
echo "- 保留占位文档：$PLACEHOLDER_SCOPE"
echo "- 排除自动检查文档：$SKIPPED_SCOPE"
echo "- 需立即修复：$TOTAL_WARNINGS"
echo "  - 缺少最后评审字段：$MISSING_FIELD"
echo "  - 严格检查范围内仍为占位值：$PLACEHOLDER_VALUE"
