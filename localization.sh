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

rm ~/.config/foot/foot.ini
cp ~/.config/foot/$current_host/foot.ini ~/.config/foot/
