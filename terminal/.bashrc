alias clr="clear"

## Colorize the ls output ##
alias l="ls"
alias ls='ls --color=auto'
 
## Use a long listing format ##
alias ll='ls -la'
 
## Show hidden files ##
alias l.='ls -d .* --color=auto'

alias apt-get='sudo apt-get'

alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

alias now="nowtime && nowdate"
alias nowtime='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'

alias svi='sudo vi'
alias vis='vim "+set si"'
alias edit='vim'

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

alias su='sudo'

## this one saved by butt so many times ##
alias wget='wget -c'

# To open last edited file
alias lvim="!vi"

# To open File in installed sublime text editor
alias nsubl="subl.exe -n"
alias asubl="subl.exe -a"

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# runs `source` for you once you save&exit the file. `source` picks up changes in the file.
alias bashrc="vim ~/.bashrc && source ~/.bashrc"


