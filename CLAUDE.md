# CLAUDE.md

## What This Repo Is

A [chezmoi](https://chezmoi.io) dotfiles repository for macOS. Files here are managed by chezmoi and applied to `$HOME`. The `dot_` prefix maps to `.` (e.g., `dot_zshrc` → `~/.zshrc`), and `dot_config/` maps to `~/.config/`.

## Architecture

File are using chezmoi file naming conventions.

### Zsh Configuration

Modular structure loaded by `dot_zshrc` → `dot_config/zsh/rc.d/` in numeric order:

| File | Purpose |
|------|---------|
| `00-zinit.zsh` | zinit bootstrap, tmux/key-bindings, starship prompt, mise fallback on Linux |
| `01-plugins.zsh` | OMZ libs/plugins (deferred) |
| `02-completions.zsh` | zsh-completions + single deferred compinit |
| `03-ui.zsh` | fzf shell integration, fzf-tab, autosuggestions, syntax highlighting |
| `05-mise.zsh` | `mise activate` for interactive shells |
| `10-ai-functions.zsh` | Wrappers for AI CLIs (Claude, Codex) |
| `20-local-completions.zsh` | Cached completions for machine-local CLIs |
| `21-exe-completions.zsh` | ssh host completion for exe.dev VMs |
| `25-fzf.zsh` | fzf options and helper functions |
| `30-aliases.zsh` | Aliases |
| `90-zoxide.zsh` | zoxide (smart `cd`) |
| `91-try-rs.zsh` | try-rs shell integration |

`dot_zprofile` sets PATH and loads mise shims for login shells. Secrets (API keys) go in `~/.config/zsh/.secret`; machine-local config goes in `~/.zshrc.local`. Both are sourced by `dot_zshrc` but excluded from this repo.

### Packages

- `Brewfile` — system CLIs, casks, fonts, and mise itself. Applied by `.chezmoiscripts/run_onchange_before_install-packages.sh.tmpl`.
- `dot_config/mise/config.toml` — language toolchains (node, go, rust, uv, pnpm) and npm global CLIs. Applied by `.chezmoiscripts/run_onchange_after_install-mise-tools.sh.tmpl`.

### Key Managed Configs

- `dot_config/starship.toml` — Starship prompt (nerd font, multi-language)
- `dot_config/ghostty/config` — Ghostty terminal
