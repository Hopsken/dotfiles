# mise — full activation (per-directory versions, env) for interactive shells.
# Runs after 00-zinit.zsh so the Linux fallback binary is already on PATH.
(( $+commands[mise] )) && eval "$(mise activate zsh)"
