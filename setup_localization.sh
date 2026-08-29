#!/bin/bash

hosts=("lizarddoggo" "splash" "default_fallback")

target_dir=""
ls dotconfig/
read -p "input target directory: " target_dir
target_path="$HOME/.config/$target_dir"

ls -a $target_path/ || ( echo "Aborting" && exit )

input_files=""
read -p "input target conf files, demlimit w/ spaces: " target_files

target_files=($target_files)

confirm_setup=""
read -p "confirm setup (destructive) y/n: " confirm_setup
if [ "$confirm_setup" = "y" ]; then
	for i in "${hosts[@]}"
	do
		mkdir $target_path/$i
		touch $target_path/.gitignore
		touch $target_path/$i/.gitignore
		for j in "${target_files[@]}"
		do
			cp $target_path/$j $target_path/$i/ || ( echo "Aborting" && exit )
			grep "$j" $target_path/.gitignore || echo "$j" >> $target_path/.gitignore
			echo "!$j" >> $target_path/$i/.gitignore
		done
	done

	echo "localization setup complete"
	echo "REMINDER: ADD LOCALIZATION TARGET TO localization.sh, GIT RM --CACHED"
fi
