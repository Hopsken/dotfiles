if ! whence -w zinit >/dev/null 2>&1; then
  return
fi

#--- Completion providers (wait 0b) ---#

zinit ice wait"0b" lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

#--- compinit (wait 0c) — single call, after all providers ---#

zinit ice wait"0c" lucid id-as"_compinit" atload'
    zstyle ":completion:*" menu select
    zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}"
    zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
    zpcompinit; zpcdreplay'
zinit light zdharma-continuum/null
