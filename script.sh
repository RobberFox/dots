#!/bin/sh
sudo apt install psmisc acpi htop xinput pulseaudio alsa-utils fzf zip xclip sxiv rename build-essential ccache fd-find ripgrep python3 lua5.4 pipx npm awesome zathura texlive-full flameshot krita inkscape mpv xserver-xephyr cmus

# wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
# cd ~/.local/share/fonts
# unzip JetBrainsMono.zip
# rm JetBrainsMono.zip
# fc-cache -fv

ln -s ~/dotsFox/nvimFox ~/.config/nvim
ln -s ~/dotsFox/AwesomeFox ~/.config/awesome
ln -s ~/dotsFox/KittyFoxy ~/.config/kitty
ln -s ~/dotsFox/zathuraFox ~/.config/zathura

ln -s ~/dotsFox/.xsessionrc ~/.xsessionrc
ln -s ~/dotsFox/.fdignore ~/.fdignore

# cd ~/
# 
# pipx install trash-cli
# npm install tree-sitter-cli
# 
# git clone https://github.com/jarun/nnn.git
# sudo make O_ICONS=1 strip install



ln -s ~/dotsFox/.bashrc ~/.bashrc
