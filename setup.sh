: "${REPO_ROOT:="$(pwd)"}"

mv ~/.profile $REPO_ROOT/shell/.profile

mkdir ~/.dotfiles_bk
mv ~/.bash_profile ~/.dotfiles_bk/
mv ~/.bashrc ~/.dotfiles_bk/

# symlinks
ln -s $REPO_ROOT/shell/.bash_profile ~/.bash_profile
ln -s $REPO_ROOT/shell/.bashrc ~/.bashrc
ln -s $REPO_ROOT/shell/.profile ~/.profile
if [[ "$OSTYPE" == "darwin"* ]]; then
    ln -s $REPO_ROOT/shell/.macos ~/.macos
fi

# git
mkdir ~/.config/git
ln -s $REPO_ROOT/git/config ~/.config/git/config
ln -s $REPO_ROOT/git/ignore ~/.config/git/ignore

# starship prompt
ln -s $REPO_ROOT/starship/starship.toml ~/.config/starship.toml

# conda
mkdir ~/.config/conda
ln -s $REPO_ROOT/conda/.condarc ~/.config/conda/condarc
