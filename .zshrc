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




# zoho setups
export http_proxy=http://127.0.0.1:3128
export https_proxy=http://127.0.0.1:3128
export no_proxy=127.0.0.1,127.0.0.0/8,::1,*.zohomeeting.com,*.zohoassist.com,avcliq.zoho.com,.zohomeeting.com,.zohoassist.com,*.zohopublic.com,*.zohopublic.in,*.zohopublic.eu,*.zohopublic.com.au,*.zohopublic.jp,*.zohopublic.ca,*.zohopublic.sa,us4-wss-accl.zoho.com,us4-wss.zoho.com,us3-wss-accl.zoho.com,us3-wss.zoho.com,in2-wss.zoho.in,in1-wss.zoho.in,eu1-wss.zoho.eu,eu2-wss.zoho.eu,cn2-wss.zoho.com.cn,cn3-wss.zoho.com.cn,au1-wss.zoho.com.au,au2-wss.zoho.com.au,jp1-wss.zoho.jp,jp2-wss.zoho.jp,ca1-wss.zohocloud.ca,ca2-wss.zohocloud.ca,sa1-wss.zoho.sa,sa2-wss.zoho.sa,in1-wss.arattai.in,in2-wss.arattai.in,preus4-wss.zoho.com,preus3-wss.zoho.com,us4-wss-pop.zoho.com,us3-wss-pop.zoho.com,in2-wss-pop.zoho.in,in1-wss-pop.zoho.in,eu1-wss-pop.zoho.eu,eu2-wss-pop.zoho.eu,cn2-wss-pop.zoho.com.cn,cn3-wss-pop.zoho.com.cn,au1-wss-pop.zoho.com.au,au2-wss-pop.zoho.com.au,jp1-wss-pop.zoho.jp,jp2-wss-pop.zoho.jp,ca1-wss-pop.zohocloud.ca,ca2-wss-pop.zohocloud.ca,sa1-wss-pop.zoho.sa,sa2-wss-pop.zoho.sa,in2-prewss-pop.zoho.in,in1-prewss-pop.zoho.in,us4-wss-vod.zoho.com,us3-wss-vod.zoho.com,in2-wss-vod.zoho.in,in1-wss-vod.zoho.in,eu1-wss-vod.zoho.eu,eu2-wss-vod.zoho.eu,cn2-wss-vod.zoho.com.cn,cn3-wss-vod.zoho.com.cn,au1-wss-vod.zoho.com.au,au2-wss-vod.zoho.com.au,jp1-wss-vod.zoho.jp,jp2-wss-vod.zoho.jp,ca1-wss-vod.zohocloud.ca,ca2-wss-vod.zohocloud.ca,sa1-wss-vod.zoho.sa,sa2-wss-vod.zoho.sa,in1-wss-vod.arattai.in,in2-wss-vod.arattai.in,us4-prewss-vod.zoho.com,us3-prewss-vod.zoho.com,*.zohoconference.com
export PATH=$PATH:/home/karthi-22578/PAM360Elevation/:/home/karthi-22578/.local/bin/


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
