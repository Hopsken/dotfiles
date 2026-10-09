# History filtering
#
# Very long commands (typically agent-generated one-liners) are kept in the
# in-memory history of the current session (up-arrow still works) but never
# written to $HISTFILE. Threshold is in characters; override in ~/.zshrc.local.
: ${HIST_MAX_CMD_LENGTH:=120}

autoload -Uz add-zsh-hook

_skip_long_history() {
  # $1 is the full command line (including trailing newline)
  # 2 = keep in session history, don't write to file
  (( ${#1} > HIST_MAX_CMD_LENGTH )) && return 2
  return 0
}
add-zsh-hook zshaddhistory _skip_long_history
