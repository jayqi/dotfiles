# Run for interactive shells

startup_log "Sourcing $XDG_CONFIG_HOME/bash/interactive.bash ..."

for f in "$XDG_CONFIG_HOME/bash/conf.d/"*.bash; do
  [[ -r "$f" ]] && source "$f"
done
