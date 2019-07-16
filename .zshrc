# Set up the prompt

autoload -Uz promptinit
promptinit
# prompt adam1
export TERM=xterm-256color

### zsh options###
setopt histignorealldups sharehistory
# cdコマンドを省略してディレクトリ名のみの入力で移動
setopt auto_cd
# cd -<tab>で以前移動したディレクトリを表示
setopt auto_pushd

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=50000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# === PECO ===
function find_cd() {
    cd "$(find . -type d | peco)"  
}

alias fc='find_cd'

function peco-history-selection() {
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER             # カーソルを文末に移動
    zle -R -c                   # refresh<Paste>
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection
# === end PECO ===

# === ALIAS ===
# general
alias ll='ls -l'

# git
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gd='git diff'
alias gdh='git diff HEAD'
alias gds='git diff --stat'
alias gp='git pull'
alias gst='git status'
alias 

# docker
alias de='docker exec -it'
alias dc='docker'
alias dp='docker ps -a'

# ansible
alias ap='ansible-playbook'
alias api='ansible-playbook -i'

# aws
alias aws3l='aws s3 ls'
alias awcfl='aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE'
alias awcfd='aws cloudformation delete-stack --stack-name'

# files
alias ivim='nvim ~/.config/nvim/init.vim'
alias dein='nvim ~/.config/nvim/dein.toml'

# others
alias nv='nvim'
alias kc='kubectl'
alias kcg='kubectl get'
alias kca='kubectl apply'

# === end ALIAS ===

# === vcs_info ===
RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'
# === end vcs_info ===

[ -f ~/.zshrc.work ] && source ~/.zshrc.work
