STARTUP_LOGGING_SH="${XDG_CONFIG_HOME:-$HOME/.config}/bash/startup-logging.bash"
if [[ -r "$STARTUP_LOGGING_SH" ]]; then
  source "$STARTUP_LOGGING_SH"
else
  startup_log() { :; }
fi

startup_log "Sourcing .bash_profile ..."

if [[ -r "$HOME/.bashrc" ]]; then
  source "$HOME/.bashrc"
fi
