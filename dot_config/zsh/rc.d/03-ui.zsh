# Bash-like word boundaries: stop at /, ., -, =, etc.
WORDCHARS='_'

if ! whence -w zinit >/dev/null 2>&1; then
   return
fi

# fzf keybindings & completion (wait 1 — after compinit at 0c)
zinit ice wait"1" lucid id-as"fzf-shell" has"fzf" \
     atclone'fzf --zsh > init.zsh 2>/dev/null || true' \
     atpull"%atclone" src"init.zsh" nocompile'!'
zinit light zdharma-continuum/null

# fzf-tab (after compinit + fzf)
zinit ice wait"1" lucid atload"
     zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -G \$realpath'
     zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls -G \$realpath'"
zinit light Aloxaf/fzf-tab

# Autosuggestions
zinit ice wait"1" lucid atinit"ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20" atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# Syntax highlighting (must be last plugin)
# Keep command input on the terminal foreground and restrict semantic colors
# to the terminal's ANSI palette.
zinit ice wait"1" lucid \
     atinit"typeset -gA FAST_HIGHLIGHT; FAST_HIGHLIGHT[git-cmsg-len]=100" \
     atload'
       FAST_HIGHLIGHT_STYLES[alias]=none
       FAST_HIGHLIGHT_STYLES[suffix-alias]=none
       FAST_HIGHLIGHT_STYLES[builtin]=none
       FAST_HIGHLIGHT_STYLES[function]=none
       FAST_HIGHLIGHT_STYLES[command]=none
       FAST_HIGHLIGHT_STYLES[precommand]=none
       FAST_HIGHLIGHT_STYLES[hashed-command]=none
       FAST_HIGHLIGHT_STYLES[single-sq-bracket]=none
       FAST_HIGHLIGHT_STYLES[double-sq-bracket]=none
       FAST_HIGHLIGHT_STYLES[variable]=none
       FAST_HIGHLIGHT_STYLES[here-string-text]=none
       FAST_HIGHLIGHT_STYLES[here-string-var]=fg=cyan
       FAST_HIGHLIGHT_STYLES[subtle-bg]=none
       FAST_HIGHLIGHT_STYLES[secondary]=""
     '
zinit light zdharma-continuum/fast-syntax-highlighting

#--- Programs ---#

zinit ice wait"1" lucid as"command" pick"zsh-bench"
zinit light romkatv/zsh-bench
