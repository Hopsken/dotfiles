 #Bash-like word boundaries: stop at /, ., -, =, etc.
 WORDCHARS='_'

 if ! whence -w zinit >/dev/null 2>&1; then
   return
 fi

 # fzf keybindings & completion (wait 0d)
 zinit ice wait"0d" lucid id-as"fzf-shell" has"fzf" \
     atclone'fzf --zsh > init.zsh 2>/dev/null || true' \
     atpull"%atclone" src"init.zsh" nocompile'!'
 zinit light zdharma-continuum/null

 # fzf-tab (after compinit + fzf)
 zinit ice wait"0d" lucid atload"
     zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -G \$realpath'
     zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls -G \$realpath'"
 zinit light Aloxaf/fzf-tab

 # Autosuggestions
 zinit ice wait"0d" lucid atinit"ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20" atload"_zsh_autosuggest_start"
 zinit light zsh-users/zsh-autosuggestions

 # Syntax highlighting (must be last plugin)
 zinit ice wait"0d" lucid atinit"typeset -gA FAST_HIGHLIGHT; FAST_HIGHLIGHT[git-cmsg-len]=100"
 zinit light zdharma-continuum/fast-syntax-highlighting

 #--- Programs ---#

 zinit ice wait"1" lucid as"command" pick"zsh-bench"
 zinit light romkatv/zsh-bench
