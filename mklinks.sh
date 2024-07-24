#.config/ files
dot_config_files=$(ls | grep -v "mklinks.sh")
echo "~/.config/" $dot_config_files

#hidden files, excluding .gitconfig (do separately)
hidden_files=$(ls -d .?* | grep -v ".git")
echo "~/" $hidden_files

#symlinking .gitconfig* files separately
git_config_files=$(ls -d .?* | grep ".gitconfig")
echo "~/ (.gitconfig*)" $git_config_files

symlink_challenge=""
read -p "symlink all? yes, no: " symlink_challenge

if [[ $symlink_challenge != "yes" ]] && [[ $symlink_challenge != "no" ]]; then
  echo INVALID
  exit 1
elif [[ $symlink_challenge == "no" ]]; then
  echo "choose files to symlink (separate with space):"
  
  read -p "~/.config/ : " dot_config_files
  read -p "~/ : " hidden_files
  read -p "~/ (.gitconfig*) : " git_config_files

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
  #ln -s $HOME/dotfiles/$i $HOME/.config/$i
  echo OK $i
done

echo "~/"
#hidden files, excluding .gitconfig (do separately)
for i in $hidden_files; do
  #ln -s $HOME/dotfiles/$i $HOME/$i
  echo OK $i
done

echo "~/ (.gitconfig*)"
#symlinking .gitconfig* files separately
for i in $git_config_files; do
  #ln -s $HOME/dotfiles/$i $HOME/$i
  echo OK $i
done
