# Run for all shells

startup_log "Sourcing $XDG_CONFIG_HOME/bash/env.bash ..."

# Sentinel for running only once per shell
if [[ -n "${__ENV_BASH_LOADED:-}" ]]; then
  return
fi
__ENV_BASH_LOADED=1

## XDG

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

## PATH

# Homebrew
# Should go before PATH section
if [[ -x /opt/homebrew/bin/brew ]]; then
  # Apple Silicon Homebrew
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  # Intel Homebrew
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Add XDG bin directory to path
PATH="$HOME/.local/bin:$PATH"

# coreutils (if installed via brew)
if [[ -n "${HOMEBREW_PREFIX:-}" ]] && [[ -d "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" ]]; then
  PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
fi

# Docker Desktop CLI helpers (if present)
if [[ -d "$HOME/.docker/bin" ]]; then
  PATH="$HOME/.docker/bin:$PATH"
fi

## EDITOR

export EDITOR="nano"
if command -v cot > /dev/null 2>&1; then
  export VISUAL="cot"
else
  export VISUAL="nano"
fi

## PROGRAM CONFIGURATION

# Pipenv
export PIPENV_VENV_IN_PROJECT=1

# Poetry
export POETRY_VIRTUALENVS_IN_PROJECT=true
