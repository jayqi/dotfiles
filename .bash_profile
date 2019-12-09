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

# Created by `userpath` on 2019-11-13 04:14:50
export PATH="$PATH:/Users/Jay/.local/bin"
