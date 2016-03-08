#!/bin/bash

PWD=`pwd`

if [ ! -e generate.vim ]; then
	echo "Missing generate.vim. Please clone using this command"
	echo "git clone https://github.com/takaite/tkt-vimrc"
fi

if [ -e ~/.vimrc ]; then
	echo "I found a .vimrc to this user. If you choose continue"
	echo "all configuration will be deleted. What do you want?"

	read -p "(C)ontinue or (A)bort? " -n 1 -r
	echo    # (optional) move to a new line
	if [[ ! $REPLY =~ ^[Cc]$ ]]
	then
	    exit
	else
	    rm -rf ~/.vim*
	fi
fi

rm -rf ~/.vim*

sudo apt-get install python-dev

cp ./generate.vim ~/.vimrc
cp ./.vimrc.local ~/
vim +NeoBundleInstall +qall
