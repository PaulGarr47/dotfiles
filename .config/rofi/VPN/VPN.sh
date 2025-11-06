#!/usr/bin/env bash

# Paths
theme="~/.config/rofi/powermenu/style.rasi"
wg_path="/etc/wireguard/"

# Menu options
connect="" #connect
disconnect="" #Disconnect
switch="" # Switch Server
import="" # Import Confi"
quit="" # Quit"

rofi_menu() {
	echo -e "$connect\n$disconnect\n$switch\n$import\n$quit" | \
	rofi -dmenu -p "VPN Menu" -theme "$theme" -l 5
}

connect_cmd() {
	local choice
	choice=$(basename -s .conf $(sudo ls $wg_path) | rofi -dmenu -p "Select Connection" -theme "$theme")

	if [[ -n "$choice" ]];then
		if sudo wg show | grep -q "$choice"; then
			notify-send "WireGuard" "You are already connected to $choice"
		else 
			if wg-quick up "$choice"; then
				 notify-send "WireGuard" "Sucessful connection to $choice"
			else
				notify-send "WireGuard" "Failed to connect to $choice"
			fi
		fi
	fi
}

disconnect_cmd() {
	local active
	active=$(sudo wg 2>&1 | grep interface | awk '{print $2}' | sed 's/://g' | rofi -dmenu -p  "Disconnect Selection" -theme "$theme")
	[[ -n "$active" ]] && wg-quick down "$active" && notify-send "WireGuard" "Disconnection from $active sucessful"
}
	
switch_cmd() {
	local current new
	current=$(sudo wg 2>&1 | grep interface | awk '{print $2}' | sed 's/://g' | \
	rofi -dmenu -p  "Select current connection to disconnect" -theme "$theme")
	new=$(basename -s .conf $(ls $wg_path) | rofi -dmenu -p "Select Connection" -theme "$theme")
	
	if [[ -n "$current" ]]; then
		wg-quick down "$current"
	else
		notify-send "WireGuard" "No disconnection selected"
	fi
	
	if [[ -n "$new" ]]; then
		wg-quick up "$new"
	else
		notify-send "WireGuard" "No new connection selected"
	fi
}
	
import() {
	local selected
	selected=$(find -d 2 -t file -e conf . | rofi -dmenu -p "Select to copy" -multi-select -mesg "Shift + Enter to select multiple" -theme "$theme")
	
	if [[ -n "$selected" ]]; then
		echo "$selected" | xargs -I{} cp -f "{}" "$wg_path"
		fd -t file -e conf . "$wg_path" -x sudo chmod 644
		notify-send "WireGuard" " Configs imported successfully"
	fi
}
chosen="$(rofi_menu)"
case $chosen in
	"$connect")
	connect_cmd
	;;
	"$disconnect")
	disconnect_cmd
	;;
	"$switch")
	switch_cmd
	;;
	"$import")
	import
	;;
	"$quit")
	exit 0
	;;
esac
