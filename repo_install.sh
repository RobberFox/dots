#!/bin/sh

git config --global core.pager "nvim -R"
git config --global color.pager no

# github-cli
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

gh auth login

# cloning
cd $HOME
git clone https://github.com/RobberFox/StellarDriven
mv StellarDriven stellardriven

mkdir -p $HOME/code
cd $HOME/code

git clone https://github.com/RobberFox/code_c
git clone https://github.com/RobberFox/code_js
git clone https://github.com/RobberFox/d2-figures
git clone https://github.com/RobberFox/FoxyLeetcode
