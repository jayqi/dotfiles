if [[ $- == *i* ]]; then
    echo "Sourcing .bashrc ..."
fi

# starship prompt
if starship --version 2>/dev/null; then
    eval "$(starship init bash)"
else
    # Show git branch in prompt
    parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    }
    PS1="\w \[\e[0;33;49m\]\$(parse_git_branch)\[\e[0;0m\]$ "
    export PS1="\[\033[32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \$ "
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
