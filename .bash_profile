echo "Sourcing .bash_profile ..."

if [ -f $HOME/.profile ]; then
    source ~/.profile
fi
if [ -f $HOME/.bashrc ]; then
    source ~/.bashrc
fi
if [ -f $HOME/.macos ] && [[ "$OSTYPE" == "darwin"* ]]; then
    source ~/.macos
fi
