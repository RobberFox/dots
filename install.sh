#!/bin/sh

COMPILATION_DIR="$HOME/Compilation/"
mkdir -p $COMPILATION_DIR

echo "=============="
echo "Dotfiles Setup"
echo "=============="
echo

# Basic packages
sudo apt install cmake psmisc acpi htop xinput pulseaudio alsa-utils fzf zip xclip sxiv rename build-essential ccache fd-find ripgrep python3 lua5.4 pipx npm awesome zathura flameshot krita inkscape firefox-esr mpv xserver-xephyr cmus libreoffice-calc
# sudo apt install texlive-full

# JetBrainsMono font
cd $HOME/.local/share/fonts
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.tar.xz --output JetBrainsMono.tar.xz
unxz JetBrainsMono.tar.xz && tar -xf JetBrainsMono.tar && rm JetBrainsMono.tar
fc-cache -fv

# xkb-switch
cd $COMPILATION_DIR
git clone https://github.com/sergei-mironov/xkb-switch.git && cd xkb-switch
mkdir build && cd build
cmake ..
make
sudo make install

# trash-cli
pipx install trash-cli

# nvim
sudo npm install -g tree-sitter-cli
cd $COMPILATION_DIR
sudo apt-get install ninja-build gettext cmake unzip curl
git clone https://github.com/neovim/neovim && cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux-x86_64.deb
sudo dpkg -i nvim-linux-x86_64.deb

# kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

mkdir -p ~/.local/share/applications/
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
echo 'kitty.desktop' > ~/.config/xdg-terminals.list

# Other software
cd $HOME
RESULT=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep "browser_download_url.*deb")
DOWNLOAD_LINK=$(echo $RESULT | cut -d : -f 2,3 | tr -d \")
curl -L $DOWNLOAD_LINK --output Obsidian.deb

curl -L https://discord.com/api/download?platform=linux --output Discord.deb

sudo dpkg -i Obsidian.deb Discord.deb && rm Obsidian.deb Discord.deb

# Symbolic links
ln -sf ~/dotsFox/nvimFox ~/.config/nvim
ln -sf ~/dotsFox/AwesomeFox ~/.config/awesome
ln -sf ~/dotsFox/KittyFoxy ~/.config/kitty
ln -sf ~/dotsFox/zathuraFox ~/.config/zathura
ln -sf ~/dotsFox/X11 ~/.config/X11

ln -sf ~/dotsFox/.xsessionrc ~/.xsessionrc
ln -sf ~/dotsFox/.fdignore ~/.fdignore

ln -sf ~/dotsFox/.bashrc ~/.bashrc
touch ~/.obsidian_key.sh
