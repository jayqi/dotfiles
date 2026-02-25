## XDG

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# ignore successive duplicates in history
export HISTCONTROL=ignoredups

## EDITOR

export EDITOR="nano"
if command -v cot >/dev/null 2>&1; then
	export VISUAL="cot"
else
	export VISUAL="nano"
fi

## PIPENV

export PIPENV_VENV_IN_PROJECT=1

## POETRY

export POETRY_VIRTUALENVS_IN_PROJECT=true
