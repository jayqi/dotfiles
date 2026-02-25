if [[ $- != *i* ]]; then
    >&2 echo "Non-interactive shell: skipping .bashrc ..."
    return
else
    >&2 echo "Sourcing .bashrc ..."
fi

# Ensure XDG base directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"


# Always load environment setup
if [[ -r "$XDG_CONFIG_HOME/bash/env.bash" ]]; then
  source "$XDG_CONFIG_HOME/bash/env.bash"
fi

# Only run the rest in interactive shells
case $- in
  *i*) ;;
  *) return ;;
esac

# Interactive-only setup
if [[ -r "$XDG_CONFIG_HOME/bash/interactive.bash" ]]; then
  source "$XDG_CONFIG_HOME/bash/interactive.bash"
fi

# Load machine-local overrides (NOT tracked)
if [[ -r "$HOME/.bashrc.local" ]]; then
  source "$HOME/.bashrc.local"
fi

>&2 echo "PATH=${PATH}"

>&2 echo ""
>&2 fastfetch
