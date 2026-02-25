err() { printf "%s\n" "$*" >&2; }

path() { echo "PATH=${PATH}" >&2; }

## Safety wrappers

# Safety wrapper for `code`
# Prevent accidentally opening VS Code at $HOME or $HOME/repos
code() {
  local target
  if [[ "$#" -eq 0 ]]; then
    # No arguments means we open the current directory.
    target="$(pwd)"
  elif [[ "$#" -eq 1 ]]; then
    # Only one argument: resolve it relative to current directory.
    target="$(realpath "$1")"
  else
    # More than one argument: assume it's not a simple directory open.
    command code "$@"
    return
  fi

  # Check if the target is exactly $HOME or $HOME/repos.
  if [[ "$target" == "$HOME" || "$target" == "$HOME/repos" ]]; then
    read -p "You're opening VS Code at $target. Continue? (y/N) " confirm
    [[ "$confirm" != [Yy]* ]] && return
  fi

  command code "$@"
}

# Safety wrapper for `pip`
# Prevent accidentally pip installing into global or base environment
pip() {
  local active_pip=$(command -v pip)
  if [[ -z $active_pip ]]; then
    >&2 echo "pip: command not found"
    return 1
  fi
  local active_python=$(command -v python)
  if [[ $(dirname $active_pip) != $(dirname $active_python) ]]; then
    >&2 echo "ERROR: Active pip does not match active python."
    >&2 echo '$(command -v pip)='$active_pip
    >&2 echo '$(command -v python)='$active_python
    return 1
  fi
  if [[ "$CONDA_SHLVL" != "0" && $(dirname $active_pip) != "$CONDA_PREFIX/bin" ]]; then
    >&2 echo "ERROR: Active pip does not match active conda environment."
    >&2 echo '$(command -v pip)='$active_pip
    >&2 echo '$CONDA_PREFIX='$CONDA_PREFIX
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
        >&2 echo "ERROR: Base conda environment pip is active."
        >&2 echo '$(command -v pip)='$active_pip
        return 1
      else
        # pip belongs to some other environment
        :
      fi
    else
      # No virtual environment active
      >&2 echo "ERROR: Active pip not in a virtual environment."
      >&2 echo '$(command -v pip)='$active_pip
      return 1
    fi
  fi
  command pip "$@"
}

## Convenience functions

# Convenience wrapper for mike
mike() {
  if [[ -f mkdocs.yml ]]; then
    command mike "$@"
  else
    (cd docs && command mike "$@")
  fi
}

aws_list() {
  grep '^\[.*\]$' $HOME/.aws/credentials | tr -d []
}

aws_activate() {
  export AWS_PROFILE="$@"
}

aws_deactivate() {
  unset AWS_PROFILE
}

gcloud_list() {
  find $HOME/.config/gcloud/credentials/ -type f -name "*.json" | while read -r file; do
    basename "${file}" .json
  done
}

gcloud_activate() {
  export GCLOUD_CONFIG="$@"
  gcloud config configurations activate $GCLOUD_CONFIG
  gcloud auth application-default login
}

gcloud_deactivate() {
  unset GCLOUD_CONFIG
  gcloud config configurations activate default
}
