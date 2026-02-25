# Write startup messages only for interactive terminals connected to a TTY.
# This avoids polluting stdout/stderr for non-interactive or machine-readable runs.
startup_log() {
  if [[ $- == *i* ]] && [[ -t 1 ]] && [[ -t 2 ]]; then
    printf '%s\n' "$*" > /dev/tty
  fi
}
