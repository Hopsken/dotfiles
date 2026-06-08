export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --ansi \
  --prompt='󰭎 ' --pointer='󰁔 ' --marker='󰄬 ' \
  --color=fg:-1,bg:-1,hl:cyan,fg+:white,bg+:black,hl+:cyan \
  --color=info:yellow,prompt:cyan,pointer:green,marker:yellow,spinner:green,header:cyan"

export FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --color=always'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"

export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git --color=always'
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --icons --color=always {}'"

# Shell integration: CTRL-T (files), ALT-C (dirs), CTRL-R (history) — requires fzf >= 0.48.0
(( $+commands[fzf] )) && eval "$(fzf --zsh 2>/dev/null)"

# fzf-tab — replaces zsh's default completion menu with fzf
# Both cd and zoxide previews consolidated here to avoid duplication with 90-zoxide.zsh
zinit wait lucid light-mode for \
    atload" zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -G \$realpath'
            zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls -G \$realpath'" \
    Aloxaf/fzf-tab

# Find in files with live preview (requires rg + bat)
fif() {
  [[ $# -eq 0 ]] && return
  rg --files-with-matches --no-messages "$1" \
    | fzf --prompt='󰈞 ' --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}

# Interactive git branch switch
fgb() {
  local branch ref
  branch=$(git branch --all | grep -v 'HEAD' \
    | fzf --prompt='󱔎 ' \
          --preview "git log --oneline --graph --date=short --color=always \
            --pretty='format:%C(auto)%h %C(magenta)%ad %C(cyan)%an %Creset%s' {1} | head -n 20") \
  || return
  ref=${branch##* }
  ref=${ref##remotes/*/}
  git checkout "$ref"
}

# Interactive git log browser (CTRL-M to open in less, CTRL-S to toggle sort)
fgl() {
  git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" \
  | fzf --prompt='󰊚 ' --ansi --no-sort --reverse --tiebreak=index \
        --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
          (grep -o '[a-f0-9]\{7\}' | head -1 |
          xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
          {}
FZF-EOF" \
        --preview "grep -o '[a-f0-9]\{7\}' <<< {} | xargs git show --color=always"
}

# Interactive process kill
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf --prompt='󰆙 ' -m | awk '{print $2}')
  [[ -n $pid ]] && xargs kill -"${1:-9}" <<< "$pid"
}
