## BASH COMPLETION

# Enable bash_completion
# https://docs.brew.sh/Shell-Completion
if [[ -n "${HOMEBREW_PREFIX:-}" ]]; then
  if [[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]]; then
    source "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
  elif [[ -d "$HOMEBREW_PREFIX/etc/bash_completion.d" ]]; then
    for completion in "$HOMEBREW_PREFIX"/etc/bash_completion.d/*; do
      [[ -r "$completion" ]] && source "$completion"
    done
  fi
fi
