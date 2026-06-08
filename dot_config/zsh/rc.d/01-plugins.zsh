if ! whence -w zinit >/dev/null 2>&1; then
  return
fi

#--- OMZ libraries (wait 0a) ---#

zinit ice wait"0a" lucid atinit"HIST_STAMPS=dd.mm.yyyy"
zinit snippet OMZL::history.zsh

zinit ice wait"0a" lucid
zinit snippet OMZL::functions.zsh

zinit ice wait"0a" lucid
zinit snippet OMZL::clipboard.zsh

zinit ice wait"0a" lucid
zinit snippet OMZL::correction.zsh

zinit ice wait"0a" lucid atload"alias ..='cd ..'; alias ls='ls -G'"
zinit snippet OMZL::directories.zsh

zinit ice wait"0a" lucid
zinit snippet OMZL::git.zsh

zinit ice wait"0a" lucid
zinit snippet OMZL::grep.zsh

#--- Plugins (wait 0a) ---#

zinit ice wait"0a" lucid atload"alias gfh='git commit -a --fixup HEAD'"
zinit snippet OMZP::git

zinit ice wait"0a" lucid
zinit snippet OMZP::command-not-found

zinit ice wait"0a" lucid
zinit snippet OMZP::kubectl

zinit ice wait"0a" lucid
zinit light MichaelAquilina/zsh-you-should-use

zinit ice wait"0a" lucid
zinit light hlissner/zsh-autopair
