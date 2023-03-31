# Post Installation Setup Script (PISS)
The script comes in 2 flavours: Debian & RHEL
While this sets up a system to *my* liking, feel free to use (or modify) it to suite your *nix setup needs.

An overview of what's happening:
## Debian:
* App switcher only switches through apps in the current workspace
* Update and upgrade, -y flag added for accepting prompt by default
* Install Nala, a front-end for apt
* Use nala instead of apt and apt-get
* Install packages required for the rest of the script (software-properties-common apt-transport-https wget)
* Espanso (A text expander. Personally, I can't use a machine without it)
* Trackpad Gestures (Set up Windows like gestures on x11)
* Keyboard Config (Custom keymap resembling Windows)
* Also installs the following: Brave browser, VSCode,Github Desktop, Anaconda, Zoom, Figma, Fonts, Cloudfare Warp,CopyPath for Nautilus, non-free codecs, gnome-tweaks, VLC media player and Shotwell Image Viewer

## RHEL:
* Update and upgrade, -y flag added for accepting prompt by default
* Install wget which is required for the rest of the script
* Espanso (A text expander. Personally, I can't use a machine without it. Installation on wayland is hugely different (and much more complicated) from x11)
* Keyboard Config (Custom keymap resembling Windows)
* Also installs the following: Brave browser, VSCode,Github Desktop, Anaconda, Zoom, Figma, Fonts, Cloudfare Warp,CopyPath for Nautilus, gnome-tweaks

## As for the differences:
* Fedora on wayland doesn't play well with the trackpad gestrure customization tool
* Nala is not needed as dnf is the package manager on Fedora
* VLC and Shotwell need to be installed via flatpak or the software store on Fedora