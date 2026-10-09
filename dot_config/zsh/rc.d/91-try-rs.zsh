# try-rs shell integration (brew-installed binary).
# `try-rs --setup-stdout zsh` emits the cd wrapper and completion; cache it via
# zinit (refreshed on `zinit update`). zinit queues compdef calls made while
# sourcing, so replay them (compinit already ran at 0c).
if (( $+commands[try-rs] )); then
  zinit ice wait"1" lucid id-as"try-rs-init" \
    atclone"try-rs --setup-stdout zsh > init.zsh" \
    atpull"%atclone" src"init.zsh" nocompile'!' atload"zicdreplay -q"
  zinit light zdharma-continuum/null
fi
