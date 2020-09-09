mv ~/.profile shell/.profile

mkdir ~/.dotfiles_bk
mv ~/.bash_profile ~/.dotfiles_bk/
mv ~/.bashrc ~/.dotfiles_bk/

# symlinks
ln -s --relative shell/.bash_profile ~/.bash_profile
ln -s --relative shell/.bashrc ~/.bashrc
ln -s --relative shell/.profile ~/.profile
if [[ "$OSTYPE" == "darwin"* ]]; then
    ln -s --relative shell/.macos ~/.macos
fi

# git
ln -s --relative git/.gitconfig ~/.gitconfig
ln -s --relative git/.gitignore_global ~/.gitignore_global

# starship prompt
ln -s --relative starship/starship.toml ~/.config/starship.toml

# conda
ln -s --relative conda/.condarc ~/.condarc
