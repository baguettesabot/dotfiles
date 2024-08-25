#.config/ files
dot_config_files=$(ls dotconfig)
echo "~/.config/" $dot_config_files

#$HOME/ files
home_files=$(\ls home -A)
echo "~/" $home_files

symlink_challenge=""
read -p "symlink all? yes, no: " symlink_challenge

if [[ $symlink_challenge != "yes" ]] && [[ $symlink_challenge != "no" ]]; then
  echo INVALID
  exit 1
elif [[ $symlink_challenge == "no" ]]; then
  echo "choose files to symlink (separate with space):"
  
  read -p "~/.config/ : " dot_config_files
  read -p "~/ : " home_files

  selective_symlink_challenge=""
  read -p "confirm selective symlink? (yes, no) " selective_symlink_challenge
  if [[ $selective_symlink_challenge != "yes" ]]; then
    echo EXIT
    exit 0
  fi
fi

echo "~/.config/"
#.config/ files
for i in $dot_config_files; do
  ln -s $HOME/dotfiles/dotconfig/$i $HOME/.config/$i
  echo OK $i
done

echo "~/"
#$HOME/ files
for i in $home_files; do
  ln -s $HOME/dotfiles/home/$i $HOME/$i
  echo OK $i
done
