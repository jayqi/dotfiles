if [[ $- != *i* ]]; then
    >&2 echo "Non-interactive shell: skipping .bashrc ..."
    return
else
    >&2 echo "Sourcing .bashrc ..."
fi

# Ensure XDG base directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Only run the rest in interactive shells
case $- in
  *i*) ;;
  *) return ;;
esac

# Load main XDG-managed bash config
if [[ -r "$XDG_CONFIG_HOME/bash/bashrc" ]]; then
  source "$XDG_CONFIG_HOME/bash/bashrc"
fi

# Load machine-specific overrides (NOT tracked)
if [[ -r "$HOME/.bashrc.local" ]]; then
  source "$HOME/.bashrc.local"
fi
