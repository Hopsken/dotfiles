zinit wait lucid light-mode for \
    as"command" from"gh-r" \
    atclone"./zoxide init zsh > init.zsh" \
    atpull"%atclone" \
    src"init.zsh" nocompile'!' \
    ajeetdsouza/zoxide

# try-rs shell integration (brew-installed binary)
if (( $+commands[try-rs] )); then
    zinit wait lucid for \
        id-as"try-rs-init" \
        atclone"try-rs --setup zsh > init.zsh" \
        atpull"%atclone" \
        src"init.zsh" nocompile'!' \
        zdharma-continuum/null
fi
