# Local completion cache for machine-specific CLIs.
# Example in ~/.zshrc.local:
#   zsh-cache-completion hermes hermes completion zsh
#
# Refresh all declared local completions:
#   zsh-refresh-completion-cache

ZSH_LOCAL_COMPLETION_DIR="$XDG_CACHE_HOME/zsh/completions"
[[ -d "$ZSH_LOCAL_COMPLETION_DIR" ]] || mkdir -p "$ZSH_LOCAL_COMPLETION_DIR"

fpath=(
  "$ZSH_LOCAL_COMPLETION_DIR"
  "$XDG_CONFIG_HOME/zsh/completions"
  $fpath
)
typeset -U fpath
typeset -gA ZSH_LOCAL_COMPLETION_SPECS

zsh-cache-completion() {
  emulate -L zsh
  setopt pipefail no_unset

  local force=0
  if [[ "${1:-}" == "-f" || "${1:-}" == "--force" ]]; then
    force=1
    shift
  fi

  local name="${1:-}"
  [[ -n "$name" ]] || return 2
  shift
  (( $# > 0 )) || return 2

  ZSH_LOCAL_COMPLETION_SPECS[$name]="${(qq)@}"

  local cmd="$1"
  (( $+commands[$cmd] || $+functions[$cmd] || $+builtins[$cmd] )) || return 0

  local target="${ZSH_LOCAL_COMPLETION_DIR}/_${name}"
  [[ $force -eq 1 || ! -s "$target" ]] || return 0

  local tmp="${target}.$$"
  if "$@" >| "$tmp"; then
    mv "$tmp" "$target"
  else
    rm -f "$tmp"
    return 1
  fi
}

zsh-refresh-completion-cache() {
  emulate -L zsh
  setopt pipefail no_unset

  local name
  local -a spec
  for name in ${(ok)ZSH_LOCAL_COMPLETION_SPECS}; do
    eval "spec=(${ZSH_LOCAL_COMPLETION_SPECS[$name]})"
    zsh-cache-completion --force "$name" "${spec[@]}"
  done
}

if [[ -s "$ZSH_LOCAL_COMPLETION_DIR/_mise" ]] || command -v usage &>/dev/null; then
  zsh-cache-completion mise mise completion zsh
fi
