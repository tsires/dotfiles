# ~/.bashrc
 
# Check for an interactive session
[[ $- != *i* ]] && return

# Switch to 256-color mode if neccessary
[[ $TERM == xterm ]] && eval $(tset -s xterm-256color)

clear 

# Prompts
COLORS=$(tput colors)

gray() { tput setaf $((232 + $1)); }
rgb() {	tput setaf $((16 + $1 * 36 + $2 * 6 + $3)); }

if [[ $COLORS == 256 ]]; then
	C0="$(gray 23)" # Trim Color
	C1="$(rgb 1 3 0)" # Date color
	C2="$(rgb 2 5 0)" # Primary color
	C3="$(rgb 4 5 3)" # Secondary color
else
	C0="$(tput setaf 7)" # Trim Color
	C1="$(tput setaf 2)" # Date color
	C2="$(tput setaf 2)" # Primary color
	C3="$(tput setaf 3)" # Secondary color
fi
DF='%a %b %d %H:%M:%S %Z' # Date format; abbreviated (man strftime)

# The prompts
PS1='\['"$C0"'\][\['"$C1"'\]\D{'"${DF:-%R}"'}\['"$C0"'\]] \['"$(tput bold)$C2"'\]\u@\h\['"$C0"'\]:\['"$C3"'\]\w\['"$C0"'\]\$\['"$(tput sgr0)"'\] '
PS2='\[\e[0;1m\] >\[\e[0m\] '
PS3='\[\e[0;1m\] >>\[\e[0m\] '
PS4='\[\e[0;1m\] >>>\[\e[0m\] '

unset COLORS C1 C2 C2 C3 DF
export PS1 PS2 PS3 PS4
export PROMPT_DIRTRIM=3

# Environment Variables
export EDITOR=vim
export HISTCONTROL=erasedups:ignorespace

# Bash Settings
shopt -s globstar
shopt -s dotglob

# Supplemental scripts / configs
[[ -r /etc/bash_completion ]] && . /etc/bash_completion
[[ -r ~/.bash_completion ]] && . ~/.bash_completion
[[ -r ~/.pythonrc.py ]] && export PYTHONSTARTUP=~/.pythonrc.py
# Extra PATHs
[[ -d ~/bin ]] && PATH=~/bin':'$PATH
[[ -d ~/.gem/ruby/1.9.1/bin ]] && PATH=~/.gem/ruby/1.9.1/bin':'$PATH

# Aliases
alias ls='ls -h --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -la --color=auto'
alias pstree='pstree -hu'
[[ $TERM == screen* ]] && alias nestscreen='screen -t workspace screen -c ~/.screenrc-nested'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# RVM bash completion
[[ -r "$HOME/.rvm/scripts/completion" ]] && source "$HOME/.rvm/scripts/completion"
