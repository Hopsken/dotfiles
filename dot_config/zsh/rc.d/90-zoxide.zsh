# zoxide (binary installed via mise; deferred shell integration via zinit)
zinit ice wait"1" lucid id-as"zoxide-init" has"zoxide" \
    atclone"zoxide init zsh > init.zsh" \
    atpull"%atclone" src"init.zsh" nocompile'!' atload"zicdreplay -q"
zinit light zdharma-continuum/null
