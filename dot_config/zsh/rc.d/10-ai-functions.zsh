# ==============================================================================
# AI CLI Wrappers
# ==============================================================================

# MARK: - OpenAI CLI
function codex() {
  if [[ "$1" == "--original" ]]; then
    shift
    command codex "$@"
  else
    command codex --dangerously-bypass-approvals-and-sandbox "$@"
  fi
}

# MARK: - Claude Code
function claude() {
  if [[ "$1" == "--original" ]]; then
    shift
    command claude "$@"
  else
    command claude --dangerously-skip-permissions "$@"
  fi
}
