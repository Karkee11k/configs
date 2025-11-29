autoload -Uz compinit
compinit

# binding keymap emacs
bindkey -e

# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# spf for cd_on_quit
spf() {
    os=$(uname -s)

    # Linux
    if [[ "$os" == "Linux" ]]; then
        export SPF_LAST_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/superfile/lastdir"
    fi

    # macOS
    if [[ "$os" == "Darwin" ]]; then
        export SPF_LAST_DIR="$HOME/Library/Application Support/superfile/lastdir"
    fi

    command spf "$@"

    [ ! -f "$SPF_LAST_DIR" ] || {
        . "$SPF_LAST_DIR"
        rm -f -- "$SPF_LAST_DIR" > /dev/null
    }
}


# sdkman for Java
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


# fzf configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#export FZF_DEFAULT_OPTS='--layout reverse --tmux --color=bg:#000000,fg:#cdd6f4  --color=hl:#89b4fa,hl+:#f38ba8 --border=rounded --color=prompt:#f9e2af,pointer:#a6e3a1,marker:#f38ba8,spinner:#94e2d5,border:#81a1c1'

# Seoul256 Dark
#export FZF_DEFAULT_OPTS="
#  --border rounded
#  --tmux
#  --color=fg:#D8DEE9,bg:#000000,bg+:#434C5E
#
#  --color=border:#81A1C1
#  --color=hl:#A3BE8C,fg+:#D8DEE9,prompt:#81A1C1
#"

# Nord theme inspired
export FZF_DEFAULT_OPTS="
  --border rounded
  --layout reverse
  --color=fg:#D8DEE9,bg:#000000,bg+:#434C5E
  --color=border:#81A1C1
  --color=hl:#A3BE8C,fg+:#D8DEE9,prompt:#81A1C1
"


# nvim configuration
export PATH="$PATH:/opt/nvim/"






### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk


# plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# starship
eval "$(starship init zsh)"

eval "$(zoxide init zsh)"


# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# aliases
[ -f ~/.zsh_aliases ] && . ~/.zsh_aliases

# zprofile
[ -f ~/.zprofile ] && . ~/.zprofile

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh --disable-up-arrow)"

export PATH="$PATH:/home/karthi-22578/my-space/scripts"
