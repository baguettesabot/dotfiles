#!/bin/bash

valid_hosts=("lizarddoggo" "splash")
current_host=$(hostnamectl hostname)
is_host_valid=0

for i in "${valid_hosts[@]}"
do
	if [ "$i" = "$current_host" ]; then
		is_host_valid=1
	fi
done

if [ $is_host_valid -eq 0 ]; then
	current_host="default_fallback"
fi

declare -A configs
configs["foot"]="foot.ini"
configs["tofi"]="config"
configs["waybar"]="config.jsonc style.css"

for i in "${!configs[@]}"
do
	conf_files=(${configs[$i]}) 
	for j in "${conf_files[@]}"
	do
		rm ~/.config/$i/$j
		cp ~/.config/$i/$current_host/$j ~/.config/$i/
	done
done
