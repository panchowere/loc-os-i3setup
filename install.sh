#! /bin/bash

echo -e "this script will install the following programs: \n i3wm \n i3block \n lxterminal \n rofi \n picom \n feh \n Xdg-user-dir \n lxappearance \n lxpolkit \n ETC... \n And compile the following programs:\n Neovim \n \033[33mWARNING:\033[0m This script will modify configuration files"
echo "Do you agree? (Y/N):" & read YN 
function dotFiles()
{
	echo "Copying fonts to .fonts"
	mkdir -p  /home/$USER/.fonts/
	cp -r  ./fonts/* /home/$USER/.fonts/
	
	echo "Copying icons and themes"
	mkdir -p /home/$USER/.themes
	cp -r ./themes/* /home/$USER/.themes
	
	mkdir -p /home/$USER/.icons
	cp -r ./icons/* /home/$USER/.icons

	mkdir -p /home/$USER/.config/gtk3/
	cp -r ./gtk3/* /home/$USER/.config/gtk3/

	echo "Copying configuration of nvim, rofi and lxterminal to .config"
	mkdir -p /home/$USER/.config/
	cp -r ./nvim/ /home/$USER/.config/
	cp -r ./rofi/ /home/$USER/.config/
	cp -r ./lxterminal /home/$USER/.config/
	echo "Copying configuration of nvim, rofi and kitty to .config"
	mkdir -p /home/$USER/.config
	cp -r ./i3/ /home/$USER/.config/

	echo "Copying Wallpapers folder to .wallpapers"
	mkdir -p /home/$USER/.wallpapers/
	cp -r ./wallpapers/* /home/$USER/.wallpapers/
}

function nvimCompile
{

	sudo apt-get install ninja-build gettext cmake curl build-essential -y
	git clone https://github.com/neovim/neovim && cd neovim && git checkout stable
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	cd build && cpack -G DEB && sudo apt install ./nvim-*.deb -y

}

function delete-folder()
{
	i3setupDir=$(pwd)

echo "The folder "$i3setupDir" will self-destruct \n Do you agree? (Y/N)"
read selfdestroy

if [[  $selfdestroy == "y" || $selfdestroy == "Y" ]]
	then cd .. && cd ..
	rm -rf "$i3setupDir"
	echo "dir deleted!"
else
    echo "bye bye~"
fi

}

if [[ $YN == "y" || $YN == "Y" ]]
	then sudo apt install i3-wm rofi i3blocks rofi picom feh xdg-user-dirs lxterminal lxpolkit lxappearance acpi alsa-utils xclip sysstat build-essential && xdg-user-dirs-update && dotFiles && sudo apt remove neovim neovim-runtime -y && nvimCompile && delete-folder && echo "ok, Bye!" && exit 1		
elif [[ $YN == "n" || $YN == "N" ]]
	then echo "ok, Bye!" && exit 1 
else 
	echo "Error!" && exit 0
fi

