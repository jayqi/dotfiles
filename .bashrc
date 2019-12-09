if [[ $- == *i* ]]; then
  echo "Sourcing .bashrc ..."
fi

# Show git branch in prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1="\w \[\e[0;33;49m\]\$(parse_git_branch)\[\e[0;0m\]$ "
export PS1="\[\033[32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \$ "
export PATH="/usr/local/sbin:$PATH"

# ls aliases
alias ls='ls -p'
alias ll='ls -lAFh'
alias la='ls -A'

# Color ls
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# make tab cycle through commands instead of listing
bind '"\t":menu-complete'
# Display a list of the matching files
bind "set show-all-if-ambiguous on"
# Perform partial completion on the first Tab press,
# only start cycling full results on the second Tab press
bind "set menu-complete-display-prefix on"

# ignore successive duplicates in history
export HISTCONTROL=ignoredups

# Created by `userpath` on 2019-11-13 04:14:50
export PATH="$PATH:/Users/Jay/.local/bin"

# pipx completions
eval "$(register-python-argcomplete pipx)"
