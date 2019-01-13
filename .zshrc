PATH=$PATH:~/.gem/ruby/2.5.0/bin

ZSH_THEME="agnoster" # Backup theme (gets overwritten by Powerline theme if available)

# ------------- Antigen -------------

source ~/.zsh/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundles << EOBUNDLES
git
pip
lein
command-not-found
colorize
colored-man-pages
extract
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
l4u/zsh-output-highlighting
Tarrasch/zsh-bd
TamCore/autoupdate-oh-my-zsh-plugins
hlissner/zsh-autopair
unixorn/autoupdate-antigen.zshplugin
zsh-users/zsh-history-substring-search
EOBUNDLES

antigen theme $ZSH_THEME

# Tell Antigen that you're done.
antigen apply

# -----------------------------------

HYPHEN_INSENSITIVE="true" # Use hyphen-insensitive completion.

# export UPDATE_ZSH_DAYS=1 # How often to auto-update (in days). # Not needed with Antigen

ENABLE_CORRECTION="true" # Enables command auto-correction.

setopt MENU_COMPLETE # Always insert first tab completion after pressing `<Tab>`

COMPLETION_WAITING_DOTS="true" # Displays red dots whilst waiting for completion.

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Powerline theme (has to come after `source $ZSH/oh-my-zsh.sh`)
if [[ -r `python -m site --user-site`/powerline/bindings/zsh/powerline.zsh ]]; then
  source `python -m site --user-site`/powerline/bindings/zsh/powerline.zsh
else
  echo "Powerline theme doesn't exists, using default theme \"$ZSH_THEME\""
fi

if type nvim > /dev/null; then
  export VISUAL=nvim # Use NeoVim if installed, otherwise Vim
else
  export VISUAL=vim
fi
export EDITOR=$VISUAL

if [[ -r ~/.zshrc.private ]]; then
  source ~/.zshrc.private
fi

bindkey -v # Vi-mode
export KEYTIMEOUT=1

# Keybindings
bindkey -s '^[l' '^K^Uls^J'    # Alt-L clears text before running `ls`
bindkey -s '^[L' '^K^Uls -a^J' # Alt-Shift-L also shows hidden files
bindkey -s '^[[2~' '^X^E'      # `Insert` key opens $EDITOR

bindkey '^P'  up-line-or-beginning-search
bindkey '^N'  down-line-or-beginning-search
bindkey '^[p' history-substring-search-up
bindkey '^[n' history-substring-search-down
bindkey '^U'  kill-whole-line

# Vi-mode config
bindkey '^F' forward-char
bindkey '^[f' forward-word
bindkey '^B' backward-char
bindkey '^[b' backward-word
bindkey '^E' end-of-line
bindkey '^A' beginning-of-line
bindkey '^_' undo

bindkey -M vicmd -s '^[l' 'ccls^J'
bindkey -M vicmd -s '^[L' 'ccls -a^J'
bindkey -M vicmd -s '_' '^'
bindkey -M vicmd '^P' up-line-or-beginning-search
bindkey -M vicmd '^N' down-line-or-beginning-search
bindkey -M vicmd '^[p' history-substring-search-up
bindkey -M vicmd '^[n' history-substring-search-down

# Create a new directory and enter it
function mkcd() {
  mkdir -p "$@" && cd "$@"
}

alias zshrc='nvim ~/.zshrc'
alias vimrc='nvim ~/.vimrc'
alias src='source ~/.zshrc'
alias ..='cd .. && ls'
alias grep='grep -Iin --color=always'
alias grepr='grep -r'
alias s='search'
alias search='find . -iname'
alias countfiles='du -a | cut -d/ -f2 | sort | uniq -c | sort -nr'
alias listfiles='find . -type f -iname "*"'
alias xs='xargs -I % sh -c'
alias mouse-speed='echo 80 | sudo tee /sys/devices/platform/i8042/serio1/serio2/speed && echo 180 | sudo tee /sys/devices/platform/i8042/serio1/serio2/sensitivity'
alias less='less -m -N -g -i -J --underline-special --SILENT'
alias xclip='xclip -selection c'
alias c='xclip -selection clipboard'
alias v='xclip -o'
alias ls='ls -F --color'
alias lsa='ls -Fa --color'
alias m='make'
alias tree='tree -C'
alias installed='yaourt -Qqe'
alias b='bd 1'
alias open='xdg-open &>/dev/null'
alias errorlogs='journalctl --since=today'
alias screenkey='screenkey -t 1.5 -s small'
alias wifi='nmcli'
alias bats='bat --pager="less -mgi --underline-special --SILENT"'

# Git:
alias g='git'
alias gs='git status'
alias gl='git log --decorate'
alias gd='git diff'
alias gco='git checkout'
alias gp='git pull'
alias gb='git branch'
alias gw='git whatchanged'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gu='git diff HEAD@{1} HEAD'
alias gly='git log --since="yesterday"'

# Dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dot='dotfiles'
alias dots='dot status'

# Syntax highligting in less:
export LESSOPEN="| /bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
