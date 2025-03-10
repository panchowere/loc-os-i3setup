#! /bin/bash

echo -e "this script will install the following programs: \n i3wm \n i3block \n kitty \n rofi \n picom \n feh \n Neovim\n Xdg-user-dir \n lxappearance \n \033[33mWARNING:\033[0m This script will modify configuration files"
echo "Do you agree? Y/N:" & read YN 
function dotFiles()
{
	echo "Copying fonts to .fonts"
	mkdir -p  /home/$USER/.fonts/
	cp -r  ./fonts/* /home/$USER/.fonts/
	
	echo "Copying configuration of nvim, rofi and kitty to .config"
	mkdir -p /home/$USER/.config/
	cp -r ./nvim/ /home/$USER/.config/
	cp -r ./rofi/ /home/$USER/.config/
	
	echo "Copying Wallpapers folder to "$(xdg-user-dir PICTURES)""
	mkdir -p "$(xdg-user-dir PICTURES)"
	cp -r ./wallpapers/ "$(xdg-user-dir PICTURES)"
}


if [[ $YN == "y" || $YN == "Y" ]]
	then sudo apt install i3-wm rofi i3blocks rofi picom feh neovim xdg-user-dirs kitty && xdg-user-dirs-update && dotFiles
		
elif [[ $YN == "n" || $YN == "N" ]]
	then echo "ok, Bye!" && exit 1 
else 
	echo "Error!" && exit 0
fi

