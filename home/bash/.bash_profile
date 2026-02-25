>&2 echo "Sourcing .bash_profile ..."

if [[ -r "$HOME/.bashrc" ]]; then
  source "$HOME/.bashrc"
fi
