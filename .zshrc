if [[ -n "$DISPLAY" && -z "$WAYLAND_DISPLAY" ]]; then
  export XDG_SESSION_TYPE=x11
fi

autoload -U colors && colors
setopt prompt_subst
bindkey -v
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

add-zsh-hook precmd vcs_info

PS1='%{$fg[green]%}%~ %{$fg[cyan]%}${vcs_info_msg_0_}%{$reset_color%} $ '

source <(fzf --zsh)

finder() { 
    xdg-open . 
}
zle -N finder
bindkey '^f' finder

mkcd() {
  mkdir -p "$1" && cd "$1"
}

alias vim="nvim"
alias vi="nvim"
alias im="nvim"
alias p="poetry"
alias pgadmin='/usr/pgadmin4/bin/pgadmin4'
alias dotnet5="$HOME/dotnet5/dotnet"
alias ls='ls --color=auto'
export LS_COLORS="di=35:ex=31"

autoload -U compinit && compinit
zmodload zsh/complist
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

export PATH="$PATH:/usr/pgadmin4/bin"
export PATH="$HOME/.local/bin:$PATH"
export MANPAGER="nvim +Man!"

HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
