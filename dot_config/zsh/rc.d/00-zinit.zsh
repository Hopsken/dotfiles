#####################
# ZINIT             #
#####################
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

#--- Synchronous — must be ready before first prompt ---#

zinit ice atinit"ZSH_TMUX_FIXTERM=false ZSH_TMUX_AUTOSTART_ONCE=true"
zinit snippet OMZP::tmux

zinit snippet OMZL::key-bindings.zsh

# Prompt (binary from GitHub Releases, cached init)
zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Volta — Node.js version manager (binary from GitHub Releases)
local _volta_bpick
if [[ "$(uname -s)" == "Darwin" ]]; then
  _volta_bpick="volta-*-macos.tar.gz"
else
  _volta_bpick="volta-*-linux.tar.gz"
fi
zinit ice from"gh-r" as"command" bpick"$_volta_bpick" \
    atclone"mkdir -p \"$VOLTA_HOME/bin\" && cp -f volta volta-shim volta-migrate \"$VOLTA_HOME/bin/\" && \"$VOLTA_HOME/bin/volta\" setup 2>/dev/null" \
    atpull"%atclone" \
    pick"/dev/null"
zinit light volta-cli/volta
