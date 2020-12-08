# Setup Checklist

Things to install on a new machine.

## Apps

- [ ] Google Chrome

Use `brew cask install`

- [ ] iTerm2 `iterm2`
- [ ] docker `docker`
- [ ] GrandPerspective `grandperspective`
- [ ] Java `java`
- [ ] KeepingYouAwake `keepingyouawake`
- [ ] Maccy `maccy`
- [ ] Paintbrush `paintbrush`
- [ ] QuickLook-JSON `quicklook-json` 
- [ ] QuickLook-Stephen `qlstephen`
- [ ] rectangle `rectangle`
- [ ] R `r`
- [ ] RStudio `rstudio`
- [ ] Slack `slack`
- [ ] Spotify `spotify`
- [ ] SpotMenu `spotmenu`
- [ ] Visual Studio Code `visual-studio-code`

## Programs

Use `brew install`

- [ ] git `git`
- [ ] GitHub CLI `gh`
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
- [ ] `cookiecutter`
- [ ] `magic-wormhole`
- [ ] `python-dotenv`
- [ ] `quickhttp`
