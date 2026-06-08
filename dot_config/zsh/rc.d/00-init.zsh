# Bash-like word boundaries: stop at /.-= etc
WORDCHARS='_'

#####################
# ZINIT             #
#####################
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


#####################
# PROMPT            #
#####################
# Loaded eagerly (not turbo) — prompt must be ready before first draw
zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
zinit light starship/starship

########################
# Plugins              #
########################

# IMPORTANT:
# Ohmyzsh plugins and libs are loaded first as some these sets some defaults which are required later on.
# Otherwise something will look messed up

# Explanation:
# 1. Loading tmux first, to prevent jumps when tmux is loaded after .zshrc
# 2. History plugin is loaded early (as it has some defaults) to prevent empty history stack for other plugins

zinit light-mode for \
    atinit" ZSH_TMUX_FIXTERM=false ZSH_TMUX_AUTOSTART_ONCE=true" \
    OMZP::tmux \
    atinit"HIST_STAMPS=dd.mm.yyyy" \
    OMZL::history.zsh

zinit wait lucid for \
    OMZL::functions.zsh \
    OMZL::clipboard.zsh \
    OMZL::correction.zsh \
    atload" alias ..='cd ..' \
           alias ls='ls -G'" \
    OMZL::directories.zsh \
    OMZL::git.zsh \
    OMZL::grep.zsh \
    OMZL::key-bindings.zsh

#####################
# PLUGINS           #
#####################

zinit wait lucid light-mode for \
    atload" alias gcd='gco dev' alias gfh='git commit -a --fixup HEAD'" \
    OMZP::git \
    OMZP::command-not-found \
    OMZP::kubectl \
    MichaelAquilina/zsh-you-should-use \
    hlissner/zsh-autopair

# Completion loading order matters:
# 1. zsh-completions (blockf) — adds fpath entries, blocked until zpcompinit
# 2. zsh-autosuggestions — near-last
# 3. fast-syntax-highlighting — LAST, its atinit calls zpcompinit + zpcdreplay
#    zpcompinit sees all fpath entries; zpcdreplay replays captured compdef calls
zinit wait lucid light-mode for \
    blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions \
    atinit"ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20" \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    atinit" typeset -gA FAST_HIGHLIGHT; FAST_HIGHLIGHT[git-cmsg-len]=100
            zstyle ':completion:*' menu select
            zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
            zstyle ':completion:*' list-colors \"\${(s.:.)LS_COLORS}\"
            zpcompinit; zpcdreplay" \
    zdharma-continuum/fast-syntax-highlighting

#####################
# PROGRAMS          #
#####################

zinit wait lucid light-mode for \
    as"command" pick"zsh-bench" \
    romkatv/zsh-bench
