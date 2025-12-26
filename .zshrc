
export EDITOR=/bin/vim

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# alias for ssh so kitty doesn't have a issue
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
#running fastfetch on terminal startup
fastfetch 
plugins=(
git
archlinux
)
