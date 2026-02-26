set shell := ["bash", "-euo", "pipefail", "-c"]

home_bash_files := `
  {
    find home/bash -type f \( -name '.bash*' -o -name '*.bash' \) \
      | sort \
      | tr '\n' ' '
  }
`
bash_home := "{{invocation_directory()}}/home/bash"
bash_xdg_config_home := "{{invocation_directory()}}/home/bash/.config"

lint: lint-dotfiles-sh lint-home-bash

lint-dotfiles-sh:
  @shellcheck --external-sources --shell=bash dotfiles.sh
  @shfmt -d dotfiles.sh

lint-home-bash:
  #!/usr/bin/env bash
  set -euo pipefail
  HOME="{{bash_home}}"
  XDG_CONFIG_HOME="{{bash_xdg_config_home}}"
  shellcheck \
    --external-sources \
    --shell=bash \
    --exclude=SC1090,SC1091,SC2262,SC2263 \
    {{home_bash_files}}
  shfmt -d {{home_bash_files}}

format:
  @shfmt -w dotfiles.sh {{home_bash_files}}
