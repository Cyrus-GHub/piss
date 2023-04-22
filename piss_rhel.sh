#!/bin/bash

# Update and upgrade, -y flag for accepting prompt by default
sudo dnf update && sudo dnf upgrade -y

# Install packages required for the rest of the script
sudo dnf install wget -y

# Espanso
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -y
sudo dnf install @development-tools gcc-c++ wl-clipboard libxkbcommon-devel dbus-devel wxGTK3-devel -y
cargo install --force cargo-make --version 0.34.0 -y
git clone https://github.com/federico-terzi/espanso
cd espanso
cargo make --profile release --env NO_X11=true build-binary -y
sudo mv target/release/espanso /usr/local/bin/espanso
sudo setcap "cap_dac_override+p" $(which espanso)
espanso service register
espanso start
cd ~

# Keyboard Config
wget https://raw.githubusercontent.com/Cyrus-GHub/piss/main/keybindings.dconf
wget https://raw.githubusercontent.com/Cyrus-GHub/piss/main/custom-keybindings.dconf
dconf load '/org/gnome/desktop/wm/keybindings/' < keybindings.dconf -y
dconf load '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/' < custom-keybindings.dconf -y

# Brave
sudo dnf install dnf-plugins-core -y
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser -y

# VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc -y
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' -y
dnf check-update
sudo dnf install code -y

# Github Desktop
sudo dnf update
sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key -y
sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo' -y
sudo dnf update
sudo dnf install github-desktop -y

# Zoom
wget https://zoom.us/client/5.14.0.1720/zoom_x86_64.rpm
sudo dnf localinstall zoom_x86_64.rpm -y

# Figma
wget https://github.com/Figma-Linux/figma-linux/releases/download/v0.10.0/figma-linux_0.10.0_linux_x86_64.rpm
sudo dnf localinstall ./figma-linux_0.10.0_linux_x86_64.rpm -y

# Fonts
wget -O Fonts.zip https://github.com/Cyrus-GHub/piss/blob/main/Fonts%20\(aio\).zip?raw=true
sudo dnf install unzip -y
unzip Fonts.zip
sudo cp /home/cyrus/'Fonts (aio)'/*.otf /usr/share/fonts/opentype
sudo cp /home/cyrus/'Fonts (aio)'/*.ttf /usr/share/fonts/truetype

# Cloudfare Warp
wget https://pkg.cloudflareclient.com/uploads/cloudflare_warp_2023_3_258_1_x86_64_7e640027c4.rpm
sudo dnf localinstall ./cloudflare_warp_2023_3_258_1_x86_64_7e640027c4.rpm -y
warp-cli register

# CopyPath
sudo dnf install nautilus-python python3-gobject -y
git clone https://github.com/chr314/nautilus-copy-path.git
cd nautilus-copy-path
make install
nautilus -q

# Wallpaper
wget https://github.com/ItsCyrus/piss/raw/main/W.PNG

# Anaconda
curl --output anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh -y
chmod +x anaconda.sh -y
bash anaconda.sh
source ~/.bashrc


<<com
What's left, apart from a reboot?

1. espanso edit
2. Add Git SSH key
3. Install gnome-tweaks vlc shotwell
4. Gnome Extensions: Clipboard Indicator, Color Picker
5. CTT config -> Performance, Security,QEMU
6. Startup Applications:
rfkill block bluetooth
system76-power profile performance (Only on PopOS)
7. Remove the default 4-finger gestures to avoid clashes:
sudo gedit /usr/share/touchegg/touchegg.conf (Only on PopOS)
8. Just in case. Windows ISO Flasher for Linux- WoeUSB-ng:
sudo apt install git p7zip-full python3-pip python3-wxgtk4.0 grub2-common grub-pc-bin
sudo pip3 install ng-WoeUSB
com
