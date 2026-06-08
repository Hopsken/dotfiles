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

# mise — runtime version manager (fallback for Linux without brew)
if [[ "$(uname -s)" != "Darwin" ]] && ! command -v mise &>/dev/null; then
  zinit ice from"gh-r" as"command" bpick"mise-*-linux-x64.tar.gz" pick"mise/bin/mise"
  zinit light jdx/mise
fi
