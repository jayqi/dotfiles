# Ensure XDG base directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

STARTUP_LOGGING_SH="$XDG_CONFIG_HOME/bash/startup-logging.bash"
if [[ -r "$STARTUP_LOGGING_SH" ]]; then
  source "$STARTUP_LOGGING_SH"
else
  startup_log() { :; }
fi

startup_log "Sourcing .bashrc ..."

# Always load environment setup
if [[ -r "$XDG_CONFIG_HOME/bash/env.bash" ]]; then
  source "$XDG_CONFIG_HOME/bash/env.bash"
fi

# Only run the rest in interactive shells
[[ $- == *i* ]] || return

# Interactive-only setup
if [[ -r "$XDG_CONFIG_HOME/bash/interactive.bash" ]]; then
  source "$XDG_CONFIG_HOME/bash/interactive.bash"
fi

# Load machine-local overrides (NOT tracked)
if [[ -r "$HOME/.bashrc.local" ]]; then
  source "$HOME/.bashrc.local"
fi

startup_log "PATH=${PATH}"

if command -v fastfetch >/dev/null 2>&1; then
  startup_log ""
  fastfetch > /dev/tty
fi
