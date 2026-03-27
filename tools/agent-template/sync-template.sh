#!/usr/bin/env bash
# sync-template.sh
#
# 从 agent-best-practies-template 模板仓库同步共享内容到当前项目。
#
# 用法：
#   ./tools/agent-template/sync-template.sh [OPTIONS]
#
# 选项：
#   --dry-run              仅预览将执行的操作，不实际写入文件
#   --ref <ref>            指定模板仓库的 git ref（tag、branch 或 commit SHA）
#                          默认使用 template-version.json 中记录的 ref，
#                          若不存在则使用远程仓库 main 分支的最新版本
#   --group <name>         仅同步指定 group（可多次指定）
#                          若不指定，同步 manifest 中 enabled=true 的所有 group
#                          以及 config 中 overlays 列表启用的 overlay group
#   --config <path>        指定本地配置文件路径
#                          默认：tools/agent-template/sync-template.config.json
#   --manifest <path>      指定 manifest 文件路径（优先于模板仓库中的 manifest）
#   --template-dir <path>  使用本地目录作为模板源（跳过远程克隆，用于测试）
#   --help                 显示帮助信息
#
# 依赖：git, rsync（若未安装 rsync 则回退到 cp；cp 模式下 exclude 不生效）

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

# ── 默认值 ──────────────────────────────────────────────────────────────────
DRY_RUN=false
REF=""
SYNC_GROUPS=()
CONFIG_FILE="${SCRIPT_DIR}/sync-template.config.json"
VERSION_FILE="${SCRIPT_DIR}/template-version.json"
MANIFEST_OVERRIDE=""
TEMPLATE_DIR_OVERRIDE=""

# ── 参数解析 ─────────────────────────────────────────────────────────────────
usage() {
  sed -n '/^#!/d; /^# sync-template/,/^[^#]/{ /^[^#]/d; s/^# \{0,1\}//; p }' "$0"
  exit 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)      DRY_RUN=true; shift ;;
    --ref)          REF="$2"; shift 2 ;;
    --group)        SYNC_GROUPS+=("$2"); shift 2 ;;
    --config)       CONFIG_FILE="$2"; shift 2 ;;
    --manifest)     MANIFEST_OVERRIDE="$2"; shift 2 ;;
    --template-dir) TEMPLATE_DIR_OVERRIDE="$2"; shift 2 ;;
    --help|-h)      usage ;;
    *) echo "[ERROR] 未知参数: $1" >&2; exit 1 ;;
  esac
done

# ── 工具函数 ─────────────────────────────────────────────────────────────────
log()  { echo "[sync-template] $*"; }
info() { echo "[sync-template] INFO  $*"; }
warn() { echo "[sync-template] WARN  $*" >&2; }
err()  { echo "[sync-template] ERROR $*" >&2; exit 1; }

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || err "依赖命令未找到: $1"
}

require_cmd git

# 若用户显式指定 --manifest，立即校验文件存在性，不等到后续流程才报错
if [[ -n "$MANIFEST_OVERRIDE" ]] && [[ ! -f "$MANIFEST_OVERRIDE" ]]; then
  err "--manifest 指定的文件不存在: ${MANIFEST_OVERRIDE}"
fi

# ── 读取本地配置 ──────────────────────────────────────────────────────────────
TEMPLATE_REPO="Zoneee/agent-best-practies-template"
TEMPLATE_REPO_URL=""

if [[ -f "$CONFIG_FILE" ]]; then
  info "读取本地配置: $CONFIG_FILE"
  if command -v python3 >/dev/null 2>&1; then
    _repo=$(python3 -c "
import json
with open('${CONFIG_FILE}') as f:
  d = json.load(f)
print(d.get('templateRepo', ''))
" 2>/dev/null || true)
    [[ -n "$_repo" ]] && TEMPLATE_REPO="$_repo"

    _url=$(python3 -c "
import json
with open('${CONFIG_FILE}') as f:
  d = json.load(f)
print(d.get('templateRepoUrl', ''))
" 2>/dev/null || true)
    [[ -n "$_url" ]] && TEMPLATE_REPO_URL="$_url"
  fi
else
  warn "未找到本地配置文件: $CONFIG_FILE"
  warn "将使用默认配置（模板仓库: ${TEMPLATE_REPO}）"
fi

# ── 确定同步 ref ──────────────────────────────────────────────────────────────
if [[ -z "$REF" ]]; then
  if [[ -f "$VERSION_FILE" ]] && command -v python3 >/dev/null 2>&1; then
    _ref=$(python3 -c "
import json
with open('${VERSION_FILE}') as f:
  d = json.load(f)
print(d.get('ref', ''))
" 2>/dev/null || true)
    [[ -n "$_ref" ]] && REF="$_ref"
  fi
fi

[[ -z "$REF" ]] && REF="main"
info "使用模板 ref: ${REF}"

# ── 创建临时工作目录 ──────────────────────────────────────────────────────────
TMPDIR_WORK="$(mktemp -d)"
TEMPLATE_DIR="${TMPDIR_WORK}/template"

cleanup() {
  rm -rf "$TMPDIR_WORK"
}
trap cleanup EXIT

# ── 拉取模板仓库 ──────────────────────────────────────────────────────────────
if [[ -n "$TEMPLATE_DIR_OVERRIDE" ]]; then
  TEMPLATE_DIR="$TEMPLATE_DIR_OVERRIDE"
  info "使用本地模板目录: ${TEMPLATE_DIR}"
else
  REPO_URL="${TEMPLATE_REPO_URL:-https://github.com/${TEMPLATE_REPO}.git}"
  info "克隆模板仓库: ${REPO_URL} @ ${REF}"

  git clone "${REPO_URL}" "${TEMPLATE_DIR}" 2>&1 \
    | sed 's/^/  /' \
    || err "克隆模板仓库失败，请检查网络连接: ${REPO_URL}"
  git -C "${TEMPLATE_DIR}" checkout "${REF}" 2>&1 \
    | sed 's/^/  /' \
    || err "切换到指定 ref 失败，请检查 ref 是否正确: ${REF}"
fi

# ── 读取 manifest ─────────────────────────────────────────────────────────────
if [[ -n "$MANIFEST_OVERRIDE" ]]; then
  # 文件存在性已在参数解析阶段校验
  MANIFEST_FILE="$MANIFEST_OVERRIDE"
elif [[ -d "$TEMPLATE_DIR" ]]; then
  MANIFEST_FILE="${TEMPLATE_DIR}/manifest/template-manifest.json"
else
  MANIFEST_FILE=""
fi

[[ -z "$MANIFEST_FILE" ]] || [[ ! -f "$MANIFEST_FILE" ]] && \
  err "未找到 manifest 文件: ${MANIFEST_FILE:-（未指定）}"

info "读取 manifest: ${MANIFEST_FILE}"

# ── 解析并执行同步 ────────────────────────────────────────────────────────────
if ! command -v python3 >/dev/null 2>&1; then
  err "需要 python3 来解析 manifest JSON"
fi

# 构建命令行指定的 group 过滤列表
GROUP_FILTER=""
if [[ ${#SYNC_GROUPS[@]} -gt 0 ]]; then
  GROUP_FILTER=$(printf '%s\n' "${SYNC_GROUPS[@]}")
fi

# 用 Python 综合 manifest + config，输出同步任务列表
# 格式：group_name|source|target|mode|exclude_csv
SYNC_TASKS=$(python3 - <<PYEOF
import json, os, sys

# 读取本地配置中的 overlays 和 groupOverrides
config_overlays = []
config_group_overrides = {}
config_file = '${CONFIG_FILE}'
if os.path.exists(config_file):
    with open(config_file) as f:
        cfg = json.load(f)
    config_overlays = cfg.get('overlays', [])
    raw_overrides = cfg.get('groupOverrides', {})
    # 过滤掉以 _ 开头的元数据键（注释/示例）
    config_group_overrides = {k: v for k, v in raw_overrides.items()
                               if not k.startswith('_')}

with open('${MANIFEST_FILE}') as f:
    manifest = json.load(f)

filter_groups = """${GROUP_FILTER}""".strip().split('\n') if """${GROUP_FILTER}""".strip() else []

all_groups = manifest.get('groups', []) + manifest.get('overlayGroups', [])

for g in all_groups:
    name    = g.get('name', '')
    enabled = g.get('enabled', False)
    source  = g.get('source', '')
    target  = g.get('target', '')
    mode    = g.get('mode', 'soft-sync')
    exclude = list(g.get('exclude', []))

    # 应用 config 中的 groupOverrides
    if name in config_group_overrides:
        ov = config_group_overrides[name]
        enabled = ov.get('enabled', enabled)
        target  = ov.get('target', target)
        mode    = ov.get('mode', mode)

    # config 中 overlays 列表可直接启用对应 overlay group
    if name in config_overlays:
        enabled = True

    if filter_groups:
        if name not in filter_groups:
            continue
    else:
        if not enabled:
            continue

    exclude_csv = ','.join(exclude)
    print(f"{name}|{source}|{target}|{mode}|{exclude_csv}")
PYEOF
)

if [[ -z "$SYNC_TASKS" ]]; then
  warn "没有需要同步的 group"
  warn "提示：检查 manifest 中 enabled=true 的 group；"
  warn "      或在 config 的 overlays 中列出要启用的 overlay；"
  warn "      或通过 --group 命令行参数手动指定。"
  exit 0
fi

SYNC_COUNT=0
SKIP_COUNT=0

while IFS='|' read -r group_name source_rel target_rel mode exclude_csv; do
  [[ -z "$group_name" ]] && continue

  SOURCE_PATH="${TEMPLATE_DIR}/${source_rel}"
  TARGET_PATH="${PROJECT_ROOT}/${target_rel}"

  if [[ ! -d "$SOURCE_PATH" ]] && [[ ! -f "$SOURCE_PATH" ]]; then
    warn "源路径不存在，跳过 group '${group_name}': ${SOURCE_PATH}"
    (( SKIP_COUNT++ )) || true
    continue
  fi

  log "同步 group '${group_name}' [${mode}]: ${source_rel} → ${target_rel}"

  # 构建 rsync exclude 参数（仅允许安全字符，防止意外 rsync 行为）
  RSYNC_EXCLUDES=()
  if [[ -n "$exclude_csv" ]]; then
    IFS=',' read -ra _excl_arr <<< "$exclude_csv"
    for _excl in "${_excl_arr[@]}"; do
      if [[ "$_excl" =~ ^[a-zA-Z0-9._/:*-]+$ ]]; then
        RSYNC_EXCLUDES+=("--exclude=${_excl}")
      else
        warn "跳过非法 exclude 模式（只允许字母/数字/. - _ / : *）: '${_excl}'"
      fi
    done
  fi

  if $DRY_RUN; then
    if command -v rsync >/dev/null 2>&1; then
      rsync -av --dry-run "${RSYNC_EXCLUDES[@]+"${RSYNC_EXCLUDES[@]}"}" \
        "${SOURCE_PATH}/" "${TARGET_PATH}/" 2>&1 \
        | grep -Ev '^(sending|sent|total)' \
        | sed 's/^/  [DRY-RUN] /' || true
    else
      log "[DRY-RUN] cp -r ${SOURCE_PATH}/ → ${TARGET_PATH}/ (exclude: ${exclude_csv:-none})"
    fi
  else
    mkdir -p "$TARGET_PATH"
    if command -v rsync >/dev/null 2>&1; then
      if [[ "$mode" == "hard-sync" ]]; then
        rsync -av --delete "${RSYNC_EXCLUDES[@]+"${RSYNC_EXCLUDES[@]}"}" \
          "${SOURCE_PATH}/" "${TARGET_PATH}/" 2>&1 | sed 's/^/  /'
      else
        rsync -av "${RSYNC_EXCLUDES[@]+"${RSYNC_EXCLUDES[@]}"}" \
          "${SOURCE_PATH}/" "${TARGET_PATH}/" 2>&1 | sed 's/^/  /'
      fi
    else
      warn "rsync 未安装，回退到 cp（exclude 模式不生效）"
      cp -r "${SOURCE_PATH}/." "${TARGET_PATH}/"
    fi
  fi

  (( SYNC_COUNT++ )) || true
done <<< "$SYNC_TASKS"

# ── 更新版本文件 ──────────────────────────────────────────────────────────────
if ! $DRY_RUN; then
  SYNCED_AT="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  TEMPLATE_COMMIT=""
  if [[ -d "${TEMPLATE_DIR}/.git" ]]; then
    TEMPLATE_COMMIT=$(git -C "$TEMPLATE_DIR" rev-parse HEAD 2>/dev/null || true)
  fi

  python3 - <<PYEOF
import json, os

version_file = '${VERSION_FILE}'
data = {}
if os.path.exists(version_file):
    with open(version_file) as f:
        data = json.load(f)

data['ref'] = '${REF}'
data['syncedAt'] = '${SYNCED_AT}'
data['templateRepo'] = '${TEMPLATE_REPO}'
if '${TEMPLATE_COMMIT}':
    data['templateCommit'] = '${TEMPLATE_COMMIT}'

os.makedirs(os.path.dirname(version_file), exist_ok=True)
with open(version_file, 'w') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f"[sync-template] INFO  版本文件已更新: {version_file}")
PYEOF
fi

# ── 完成 ──────────────────────────────────────────────────────────────────────
if $DRY_RUN; then
  log "──────────────────────────────────────────────"
  log "[DRY-RUN 完成] 以上为预览，未实际写入任何文件。"
  log "去掉 --dry-run 参数后重新运行以执行实际同步。"
else
  log "──────────────────────────────────────────────"
  log "同步完成：${SYNC_COUNT} 个 group 已同步，${SKIP_COUNT} 个 group 已跳过。"
  log "如需提交变更，请运行：git diff 查看差异，然后 git add / git commit。"
fi
