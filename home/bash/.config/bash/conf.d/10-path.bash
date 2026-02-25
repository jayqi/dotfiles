## Homebrew
# Should go before PATH section
eval "$(/opt/homebrew/bin/brew shellenv)"
if [[ "$OSTYPE" == darwin* ]]; then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    # Apple Silicon Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    # Intel Homebrew
    eval "$(/usr/local/bin/brew shellenv)"
  fi
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
