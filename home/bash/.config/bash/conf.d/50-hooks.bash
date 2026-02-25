## STARSHIP
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi


## CONDA/MAMBA

# Source conda init file, if it exists
CONDA_INIT_SH="${XDG_CONFIG_HOME:-$HOME/.config}/bash/conda.sh"
if [[ -f "$CONDA_INIT_SH" ]]; then
    source "$CONDA_INIT_SH"
fi


# FNM / NODE
eval "$(fnm env --use-on-cd --shell bash)"
