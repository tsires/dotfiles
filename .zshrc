# Switch to 256-color mode if neccessary
[[ $TERM == xterm ]] && eval $(tset -s xterm-256color)

# Set Timezone before doing anything involving timestamps
export TZ='America/Chicago'

# Prompts
gray() { print "%$((232 + $1))F"; }
rgb() {	print "%$((16 + $1 * 36 + $2 * 6 + $3))F"; }
case "$(tput colors)" in
	256)
		C0="$(gray 23)" # Trim Color
		C1="$(rgb 1 3 0)" # Date color
		C2="$(rgb 2 5 0)" # Primary color
		C3="$(rgb 4 5 3)" # Secondary color
		;;
	*)
		C0="%F{white}" # Trim Color
		C1="%F{green}" # Date color
		C2="%F{green}" # Primary color
		C3="%F{yellow}" # Secondary color
		;;
esac
DF='%a %b %d %H:%M:%S %Z' # Date format; abbreviated (man strftime)

# The prompts
PS1="${C0}[${C1}%D{${DF}}${C0}] %B${C2}%n@%M${C0}:${C3}%(5~,%-1~/.../%3~,%~)${C0}%#%b%f "
PS2=$'%B >%b '
PS3=$'%B >>%b '
PS4=$'%B >>>%b '

unset C0 C1 C2 C3 DF
export PS1 PS2 PS3 PS4

# Environment Variables
export EDITOR=vim

# Supplemental scripts / configs
[[ -r ~/.pythonrc.py ]] && export PYTHONSTARTUP=~/.pythonrc.py
[[ -d ~/bin ]] && PATH=~/bin':'$PATH

# Aliases
alias ls='ls -h --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -la --color=auto'
alias pstree='pstree -hu'
[[ $TERM == screen* ]] && alias nestscreen='screen -t workspace screen -c ~/.screenrc-nested'

# The following lines were added by compinstall

zstyle ':completion:*' auto-description '%Bspecify: %d%b'
zstyle ':completion:*' completer _list _oldlist _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 'NUMERIC & 1 || ! ${+NUMERIC}'
zstyle ':completion:*' condition unambiguous
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' glob '(NUMERIC >> 2) & 1'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%BAt %l: Hit TAB for more, or the character to insert%b'
zstyle ':completion:*' matcher-list '' '' '+m:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=**' '+l:|=* r:|=*'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' menu select=long
zstyle ':completion:*' original false
zstyle ':completion:*' select-prompt '%BScrolling active: current selection at %l%b'
zstyle ':completion:*' substitute '(NUMERIC >> 1) & 1'
zstyle :compinstall filename '/home/ash/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
APPEND_HISTORY=1
HIST_IGNORE_ALL_DUPS=1
setopt appendhistory notify
bindkey -e
# End of lines configured by zsh-newuser-install

# Special key bindings
# TODO: Maybe set these dynamically, using tput.  See terminfo(5).
# Home - tput khome
# End  - tput kend
bindkey '\e[2~' overwrite-mode
bindkey '\e[3~' delete-char
case "$TERM" in
	screen*|linux)
		bindkey '\e[1~' beginning-of-line
		bindkey '\e[4~' end-of-line
		;;
	*)
		bindkey '\eOH' beginning-of-line
		bindkey '\eOF' end-of-line
		;;
esac
