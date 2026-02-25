## LS ALIASES ##

# Color ls
if ls --color -d . > /dev/null 2>&1; then
  # GNU ls (Linux and coreutils)
  alias ls='ls -p --color=auto'
  export LS_COLORS='di=36:ln=1;31:so=37:pi=1;33:ex=35:bd=37:cd=37:su=37:sg=37:tw=32:ow=32'
elif ls -G -d . > /dev/null 2>&1; then
  # BSD ls (macOS system)
  alias ls='ls -p'
  export CLICOLOR=1
  export LSCOLORS='gxBxhxDxfxhxhxhxhxcxcx'
fi

alias ll='ls -lAFh'
alias la='ls -A'
