alias ls='lsd'
alias la='lsd -la'
alias lt='ls --tree'
alias b='bat'
alias icat="kitten icat"
alias c='clear'

alias stack="$HOME/.ghcup/bin/stack"
alias fanfull="sudo sh -c 'echo 0 > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon4/pwm1_enable'"
alias fanauto="sudo sh -c 'echo 2 > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon4/pwm1_enable'"
alias art="cat ~/Downloads/Telegram\ Desktop/nayuta.txt"
alias abplay="mpv --no-video --really-quiet"
alias ppt2pdf='uv run ~/work/scripts/pdfconvert.py . && rm -f ./*.ppt ./*.pptx'

# dotfiles tracking alias
alias dot='git --git-dir=$HOME/work/dotfiles/ --work-tree=$HOME'
# alias df='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# alias dfs='df status'
# alias dfc='df commit'
# alias dfa='df add'

alias vi='nvim'
alias zed='zeditor .'
alias lc='leetcode'

alias copy='wl-copy'
alias pasta='wl-paste'
alias pastas="/home/vaibhav/work/scripts/pastas"
alias cpwd='pwd | wl-copy'
