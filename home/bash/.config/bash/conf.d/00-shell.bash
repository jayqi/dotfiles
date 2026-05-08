# History settings
HISTCONTROL=ignoredups:erasedups
HISTSIZE=10000
HISTFILESIZE=20000

# Set the terminal title to the current working directory
set_title() {
  local title='\w'
  printf '\033]0;%s\007' "${title@P}"
}
PROMPT_COMMAND=set_title
