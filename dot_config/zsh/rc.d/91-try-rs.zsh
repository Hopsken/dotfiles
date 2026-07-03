# try-rs shell integration (brew-installed binary)
if (( $+commands[try-rs] )); then
  try-rs() {
    # Pass flags/options directly to stdout without capturing.
    local arg
    for arg in "$@"; do
      case "$arg" in
        -*) command try-rs "$@"; return ;;
      esac
    done

    # try-rs prints the shell command to stdout and renders the TUI on stderr.
    local output
    output=$(command try-rs "$@")

    if [[ -n "$output" ]]; then
      eval "$output"
    fi
  }

  _try_rs_get_tries_path() {
    if [[ -n "${TRY_PATH:-}" ]]; then
      if [[ "$TRY_PATH" == *","* ]]; then
        print -r -- "$TRY_PATH" | tr ',' '\n'
      else
        print -r -- "$TRY_PATH"
      fi
      return
    fi

    local config_path tries_path
    local -a config_paths=("$HOME/.config/try-rs/config.toml" "$HOME/.try-rs/config.toml")
    for config_path in "${config_paths[@]}"; do
      if [[ -f "$config_path" ]]; then
        tries_path=$(grep -E '^[[:space:]]*tries_path[[:space:]]*=' "$config_path" 2>/dev/null | sed -E 's/.*=[[:space:]]*"?([^"]*)"?.*/\1/' | sed "s|~|$HOME|" | tr -d '[:space:]')
        if [[ -n "$tries_path" ]]; then
          if [[ "$tries_path" == *","* ]]; then
            print -r -- "$tries_path" | tr ',' '\n'
          else
            print -r -- "$tries_path"
          fi
          return
        fi
      fi
    done

    print -r -- "$HOME/work/tries"
  }

  _try_rs_complete() {
    local tries_path
    local -a dirs=()

    while IFS= read -r tries_path; do
      if [[ -d "$tries_path" ]]; then
        local -a entries=("$tries_path"/*(N-/))
        dirs+=("${entries[@]:t}")
      fi
    done < <(_try_rs_get_tries_path)

    compadd -a dirs
  }

  compdef _try_rs_complete try-rs try
fi
