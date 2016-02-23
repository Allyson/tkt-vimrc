#!/bin/bash

PWD`pwd`

if [ ! -e generate.vim ]; then
	echo "Missing generate.vim. Please clone using this command"
	echo "git clone https://github.com/takaite/tkt-vimrc"
fi

if [ -e ~/.vimrc ]; then
	echo "I found a .vimrc to this user. If you choose continue"
	echo "all configuration will be deleted. What do you want?"
	echo "(C)ontinue or (A)bort?"
	
