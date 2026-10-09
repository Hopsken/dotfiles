alias try="try-rs"
alias to="tmux new-session -A -s"
alias yolo="claude --dangerously-skip-permissions"

alias cm="chezmoi"
alias cma="chezmoi apply"
alias cmz="chezmoi diff"

# List Homebrew formulae/casks installed on request but not in the chezmoi Brewfile.
brew-drift() {
  local brewfile
  brewfile="$(chezmoi source-path)/Brewfile" || return
  [[ -f "$brewfile" ]] || { print -u2 "brew-drift: $brewfile not found"; return 1; }
  { brew leaves --installed-on-request; brew list --cask -1; } |
    awk 'NR == FNR { sub(/.*\//, ""); want[$0]; next }
         { name = $0; sub(/.*\//, "", name); if (!(name in want)) print }' \
      <(sed -nE 's/^(brew|cask) "([^"]+)".*/\2/p' "$brewfile") -
}
