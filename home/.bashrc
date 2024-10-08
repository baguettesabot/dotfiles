#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR='nvim'
export PATH=$PATH:$HOME/bin
export GRIM_DEFAULT_DIR=$HOME/Pictures/screencapture/
export HISTFILESIZE="william"

alias setup=". setupcode.sh"
alias explore=". explore.sh"
alias r=". ranger"

fortune | cowsay -f stegosaurus
