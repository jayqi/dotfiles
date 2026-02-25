#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "Error: $*" >&2
  exit 1
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STOW_DIR="$SCRIPT_DIR/home"
BACKUP_ROOT="$HOME/.dotfiles_backup"

[[ -d "$STOW_DIR" ]] || fail "Expected stow directory at $STOW_DIR"

[[ $# -eq 0 ]] || fail "This script does not accept arguments. Run './setup.sh'."

if ! command -v stow >/dev/null 2>&1; then
  fail "GNU stow is required but not installed or not in PATH."
fi

packages=()
for dir in "$STOW_DIR"/*; do
  [[ -d "$dir" ]] || continue
  pkg_name="$(basename "$dir")"
  [[ "$pkg_name" == -* ]] && fail "Package names cannot start with '-': $pkg_name"
  packages+=("$pkg_name")
done
[[ ${#packages[@]} -gt 0 ]] || fail "No stow packages found in $STOW_DIR"

STOW_FLAGS=(-R -v -t "$HOME")

run_stow() {
  local extra_flags=("$@")
  (
    cd "$STOW_DIR"
    LC_ALL=C stow "${extra_flags[@]}" "${STOW_FLAGS[@]}" "${packages[@]}"
  )
}

# preview
preview_output=""
preview_status=0
if preview_output="$(run_stow -n 2>&1)"; then
  preview_status=0
else
  preview_status=$?
fi

echo "Preview:"
echo "$preview_output"

needs_backup=0
if [[ $preview_status -ne 0 ]]; then
  backup_targets=()
  while IFS= read -r line; do
    rel=""
    if [[ "$line" == *" over existing target "* && "$line" == *" since "* ]]; then
      rel="${line##* over existing target }"
      rel="${rel%% since *}"
      if [[ "$line" != *"since neither a link nor a directory"* ]]; then
        echo "Unsupported conflict line:"
        echo "  $line"
        fail "Resolve this conflict manually before rerunning."
      fi
    elif [[ "$line" =~ ^[[:space:]]*\*[[:space:]]+existing[[:space:]]target[[:space:]]is[[:space:]]not[[:space:]]owned[[:space:]]by[[:space:]]stow:[[:space:]](.+)$ ]]; then
      rel="${BASH_REMATCH[1]}"
    else
      continue
    fi

    rel="${rel#"${rel%%[![:space:]]*}"}"
    rel="${rel%"${rel##*[![:space:]]}"}"
    rel="${rel#./}"
    [[ -n "$rel" ]] || continue
    backup_target="$HOME/$rel"

    # For "not owned by stow", only auto-back up files/symlinks.
    if [[ "$line" == *"not owned by stow"* && -d "$backup_target" && ! -L "$backup_target" ]]; then
      echo "Unsupported conflict line:"
      echo "  $line"
      fail "Directory targets not owned by stow require manual resolution."
    fi
    backup_targets+=("$backup_target")
  done <<< "$preview_output"

  if [[ ${#backup_targets[@]} -eq 0 ]]; then
    fail "Stow preview failed without recognized auto-backup conflicts."
  fi

  needs_backup=1
  echo "Detected ${#backup_targets[@]} conflict(s) to back up before apply:"
  printf '  - %s\n' "${backup_targets[@]}"
fi

if ! read -r -p "Proceed to apply? [y/N] " reply; then
  echo "Cancelled (no stdin)."
  exit 1
fi
[[ "$reply" == "y" || "$reply" == "Y" ]] || {
  echo "Cancelled."
  exit 0
}

# backup + verify
if [[ $needs_backup -eq 1 ]]; then
  backup_target=""
  backup_rel=""
  backup_dest=""
  timestamp="$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$BACKUP_ROOT"
  backup_dir="$(mktemp -d "$BACKUP_ROOT/$timestamp-XXXXXX")"
  echo "Backing up conflicts into $backup_dir"
  for backup_target in "${backup_targets[@]}"; do
    [[ -e "$backup_target" || -L "$backup_target" ]] || continue
    [[ "$backup_target" == "$HOME/"* ]] || fail "Refusing to back up non-HOME path: $backup_target"
    backup_rel="${backup_target#"$HOME"/}"
    backup_dest="$backup_dir/$backup_rel"
    mkdir -p "$(dirname "$backup_dest")"
    mv "$backup_target" "$backup_dest"
    echo "Backed up: $backup_target -> $backup_dest"
  done

  if preview_output="$(run_stow -n 2>&1)"; then
    preview_status=0
  else
    preview_status=$?
  fi

  if [[ $preview_status -ne 0 ]]; then
    echo "Preview after backup:"
    echo "$preview_output"
    fail "Preview still failing after backup. Aborting."
  fi
fi

# apply
run_stow
echo "Done."
