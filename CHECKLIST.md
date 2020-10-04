# Setup Checklist

Things to install on a new machine.

## Apps

- [ ] Google Chrome

Use `brew cask`

- [ ] iTerm2 `iterm2`
- [ ] Visual Studio Code `visual-studio-code`
- [ ] RStudio `rstudio`
- [ ] Slack `slack`
- [ ] KeepingYouAwake `keepingyouawake`
- [ ] rectangle `rectangle`
- [ ] docker `docker`
- [ ] Java `java`

## Programs

Use `brew`

- [ ] git `git`
- [ ] R `r`
- [ ] jq `jq`
- [ ] coreutils `coreutils`
  - [ ] `PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"` ([ref](https://superuser.com/questions/476575/replace-os-xs-shell-commands-with-the-linux-versions/476594#476594))
- [ ] nodejs `nvm`
- [ ] ruby `ruby-install` and `chruby`
- [ ] starship prompt `starship`

## Python

Having both pyenv and conda. ([ref](https://stackoverflow.com/a/58045984/5957621))

- [ ] pyenv `brew install pyenv`
- [ ] pyenv-virtualenv `brew install pyenv-virtualenv`
- [ ] miniconda ([link](https://docs.conda.io/en/latest/miniconda.html))

Set up standalone Jupyter

- [ ] environment `conda create --name jupyter python=3.7 jupyterlab nb_conda_kernels`
- [ ] path `export PATH="$PATH:$HOME/miniconda3/envs/jupyter/bin"`

pipx

- [ ] `awscli`
- [ ] `magic-wormhole`
- [ ] `cookiecutter`
- [ ] `quickhttp`
