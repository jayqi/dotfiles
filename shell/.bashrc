# : "${XDG_CONFIG_HOME:="$HOME/.config"}"
# : "${XDG_CACHE_HOME:="$HOME/.cache"}"
# : "${XDG_DATA_HOME:="$HOME/.local/share"}"
# : "${XDG_STATE_HOME:="$HOME/.local/state"}"

if [[ $- == *i* ]]; then
    echo "Sourcing .bashrc ..."
fi

# starship prompt
if starship -V 2>/dev/null; then
    eval "$(starship init bash)"
else
    # Show git branch in prompt
    parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    }
    PS1="\w \[\e[0;33;49m\]\$(parse_git_branch)\[\e[0;0m\]$ "
    export PS1="\[\033[32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \$ "
fi

# rtx runtime manager
if rtx -v &>/dev/null; then
    echo rtx $(rtx -v)
    eval "$(rtx activate bash)"
fi

## LS ALIASES ##

# Color ls
if ls --color -d . >/dev/null 2>&1; then
    # GNU ls (Linux)
    alias ls='ls -p --color=auto'
    export LS_COLORS='di=36:ln=1;31:so=37:pi=1;33:ex=35:bd=37:cd=37:su=37:sg=37:tw=32:ow=32'
elif ls -G -d . >/dev/null 2>&1; then
    # BSD ls (macOS system)
    alias ls='ls -p'
    export CLICOLOR=1
    export LSCOLORS='gxBxhxDxfxhxhxhxhxcxcx'
fi

alias ll='ls -lAFh'
alias la='ls -A'


## TAB-COMPLETE ##

# make tab cycle through commands instead of listing
bind '"\t":menu-complete'
# Display a list of the matching files
bind "set show-all-if-ambiguous on"
# Perform partial completion on the first Tab press,
# only start cycling full results on the second Tab press
bind "set menu-complete-display-prefix on"


# ignore successive duplicates in history
export HISTCONTROL=ignoredups

export EDITOR=nano

export MAMBA_NO_BANNER=true

# list AWS profiles
alias aws_list_profiles="grep '^\[.*\]$' ~/.aws/credentials | tr -d []"

# convenience alias for mike
mike() {
    if [[ -f mkdocs.yml ]]; then
        command mike "$@"
    else
        (cd docs && command mike "$@")
    fi
}

# Prevent accidentally pip installing into global or base environment
pip() {
    local active_pip=$(which pip)
    if [[ -z $active_pip ]]; then
        echo "pip: command not found"
        return 1
    fi
    if [[ $(dirname $active_pip) != $(dirname $(which python)) ]]; then
        echo "ERROR: Active pip does not match active python."
        echo '$(which pip)='$active_pip
        echo '$(which python)='$(which python)
        return 1
    fi
    if [[ "$CONDA_SHLVL" != "0" && $(dirname $active_pip) != "$CONDA_PREFIX/bin" ]]; then
        echo "ERROR: Active pip does not match active conda environment."
        echo '$(which pip)='$active_pip
        echo '$CONDA_PREFIX='$CONDA_PREFIX
        return 1
    fi
    if [[ "$1" == "install" ]]; then
        # Check if we're using a base environment pip
        if [[ ! -z $VIRTUAL_ENV ]]; then
            # Normal virtualenv is active
            :
        elif [[ "$CONDA_SHLVL" != 0 ]]; then
            # conda environment is active
            if [[ $(dirname $active_pip) == $(dirname $CONDA_PYTHON_EXE) ]]; then
                # pip belongs to base conda environment
                echo "ERROR: Base conda environment pip is active."
                echo '$(which pip)='$active_pip
                return 1
            else
                # pip belongs to some other environment
                :
            fi
        else
            # No virtual environment active
            echo "ERROR: Active pip not in a virtual environment."
            echo '$(which pip)='$active_pip
            return 1
        fi
    fi
    command pip "$@"
}

## XDG
# R
export R_HOME_USER="${XDG_CONFIG_DIR:-"$HOME/.config"}/R"
export R_PROFILE_USER="${XDG_CONFIG_DIR:-"$HOME/.config"}/R/profile"
export R_HISTFILE="${XDG_CONFIG_DIR:-"$HOME/.config"}/R/history"
