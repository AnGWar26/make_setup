tex:
	sudo dnf -y install texlive-scheme-basic

fonts:
	sudo dnf -y install adobe-source-code-pro-fonts adobe-source-sans-pro-fonts fontawesome-fonts

conda:
	curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && bash Miniconda3-latest-Linux-x86_64.sh

zsh:
	sudo dnf install -y zsh
	chsh -s /bin/zsh
	
ohmyzsh:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rpmfusion:
	sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf groupupdate core
	sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
	sudo dnf groupupdate sound-and-video

# only after make rpmfusion; wait for driver to build before reboot
nvidia:
	sudo dnf install akmod-nvidia 
	sudo dnf install xorg-x11-drv-nvidia-cuda

themes:
	sudo dnf install flat-remix-icon-theme flat-remix-gtk3-theme flat-remix-gtk2-theme flat-remix-theme gnome-shell-theme-flat-remix gnome-tweaks

flatpaks:
	sudo dnf install -y flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install -y com.spotify.Client com.belmoussaoui.Obfuscate com.discordapp.Discord com.valvesoftware.Steam us.zoom.Zoom com.slack.Slack com.vscodium.codium

R:
	sudo dnf install R rstudio-desktop

sshkey:
	ssh-keygen -t rsa -b 4096 -C "$(email)"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa

joplin:
	wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash

comalias:
	 echo 'alias upjoplin='wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash' >> ~/.zshrc
	 echo 'alias pkgupdate='sudo dnf update -y && flatpak update -y' >> ~/.zshrc
	 source ~/.zshrc
