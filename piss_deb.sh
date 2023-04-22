#!/bin/bash

# App switcher only switches through apps in the current workspace
gsettings set org.gnome.shell.app-switcher current-workspace-only true

# Update and upgrade, -y flag added for accepting prompt by default
sudo apt update && sudo apt upgrade -y

# Install Nala, a front-end for apt
echo "deb http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list; wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg
sudo apt update && sudo apt install nala -y

# Use nala instead of apt and apt-get
echo 'apt() {
command nala "$@"
}
sudo() {
if [ "$1" = "apt" ] | [ "$1" = "apt-get" ]; then
shift
command sudo nala "$@"
else
command sudo "$@"
fi
apt() {
command nala "$@"
}
sudo() {
if [ "$1" = "apt" ] | [ "$1" = "apt-get" ]; then
shift
command sudo nala "$@"
else
command sudo "$@"
fi' >> ~/.bashrc

echo 'apt() {
command nala "$@"
}
sudo() {
if [ "$1" = "apt" ] | [ "$1" = "apt-get" ]; then
shift
command sudo nala "$@"
else
command sudo "$@"
fi
apt() {
command nala "$@"
}
sudo() {
if [ "$1" = "apt" ] | [ "$1" = "apt-get" ]; then
shift
command sudo nala "$@"
else
command sudo "$@"
fi' >> /root/.bashrc

# Install packages required for the rest of the script
sudo apt install software-properties-common apt-transport-https wget -y

# Espanso
wget https://github.com/federico-terzi/espanso/releases/download/v2.1.8/espanso-debian-x11-amd64.deb
sudo apt install ./espanso-debian-x11-amd64.deb -y
espanso service register
espanso start
wget https://raw.githubusercontent.com/Cyrus-GHub/piss/main/base.yml
rm -r /home/cyrus/.config/espanso/match/base.yml
mv base.yml /home/cyrus/.config/espanso/match/

# Trackpad Gestures
sudo gpasswd -a $USER input
sudo apt install wmctrl xdotool -y
sudo apt install libinput-tools -y
git clone https://github.com/bulletmark/libinput-gestures.git
cd libinput-gestures
sudo make install-y
cd ~

# Keyboard Config
wget https://raw.githubusercontent.com/Cyrus-GHub/piss/main/keybindings.dconf
wget https://raw.githubusercontent.com/Cyrus-GHub/piss/main/custom-keybindings.dconf
dconf load '/org/gnome/desktop/wm/keybindings/' < keybindings.dconf
dconf load '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/' < custom-keybindings.dconf

# Brave
sudo apt install curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y

# VSCode
sudo apt-get install wget gpg -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg -y
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg -y
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' -y
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https -y
sudo apt update
sudo apt install code -y

# Github Desktop
sudo apt install git -y
sudo wget https://github.com/shiftkey/desktop/releases/download/release-3.1.1-linux1/GitHubDesktop-linux-3.1.1-linux1.deb
sudo apt install gdebi -y
sudo gdebi GitHubDesktop-linux-3.1.1-linux1.deb -y

# Anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh
shasum -a 256 Anaconda3-2022.10-Linux-x86_64.sh
bash Anaconda3-2022.10-Linux-x86_64.sh

# Zoom
wget https://zoom.us/client/5.13.5.431/zoom_amd64.deb
sudo apt install ./zoom_amd64.deb -y

# Figma
wget https://github.com/Figma-Linux/figma-linux/releases/download/v0.10.0/figma-linux_0.10.0_linux_amd64.deb
sudo apt install ./figma-linux_0.10.0_linux_amd64.deb -y

# Fonts
wget -O Fonts.zip https://github.com/Cyrus-GHub/piss/blob/main/Fonts%20\(aio\).zip?raw=true
sudo apt install unzip -y
unzip Fonts.zip
sudo cp /home/cyrus/'Fonts (aio)'/*.otf /usr/share/fonts/opentype
sudo cp /home/cyrus/'Fonts (aio)'/*.ttf /usr/share/fonts/truetype

# Cloudfare Warp
wget https://pkg.cloudflareclient.com/uploads/cloudflare_warp_2023_1_133_1_amd64_dc941b82de.deb
sudo apt install ./cloudflare_warp_2023_1_133_1_amd64_dc941b82de.deb -y
warp-cli register

# CopyPath
sudo apt install python3-nautilus python3-gi -y
git clone https://github.com/chr314/nautilus-copy-path.git
cd nautilus-copy-path
make install
nautilus -q

# Install gnome-tweaks application, VLC media player and Shotwell Image Viewer
sudo apt install gnome-tweaks vlc shotwell -y


<<com
What's left, apart from a reboot?

* espanso edit
* Add Git SSH key
* Gnome Extensions: Clipboard Indicator, Color Picker
* CTT config -> Performance, Security,QEMU
* Startup Applications:
rfkill block bluetooth
system76-power profile performance (Only on PopOS)
* Mouse Acceleration
* Wallpaper
* Remove the default 4-finger gestures to avoid clashes:
sudo gedit /usr/share/touchegg/touchegg.conf (Only on PopOS)
* Just in case. Windows ISO Flasher for Linux- WoeUSB-ng:
sudo apt install git p7zip-full python3-pip python3-wxgtk4.0 grub2-common grub-pc-bin
sudo pip3 install ng-WoeUSB
com
