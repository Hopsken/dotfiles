# dotfiles

Managed by [chezmoi](https://www.chezmoi.io/).

## 🚀 Quick Start

```bash
brew install chezmoi
chezmoi init --apply Hopsken
```

Without Homebrew (e.g. Linux):

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Hopsken
```

## 🛠 Included Configurations

- **Shell**: `zsh` managed by `zinit` for asynchronous plugin loading.
- **Prompt**: `starship`.
- **Terminal Multiplexer**: `tmux` with `catppuccin` theme and `tpm` plugin manager.
- **Tools**: `zoxide`, `fzf-tab`, `fast-syntax-highlighting`, and more.
- **Packages**: CLIs and apps via `Brewfile`; language toolchains (node, go, rust, uv) via `mise`.
- **Git**: Global ignore (`~/.config/git/ignore`).

## 📦 Requirements

The scripts expect the following to be available (or they will be installed):

- `git`, `curl`, `zsh`, `tmux`

## 🧩 Local Zsh Completions

Machine-specific CLI completions can be cached without adding the CLI itself to chezmoi.
Declare them in `~/.zshrc.local`:

```zsh
zsh-cache-completion hermes hermes completion zsh
```

The generated completion is stored under:

```text
${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions/_hermes
```

Refresh all declared local completion caches:

```zsh
zsh-refresh-completion-cache
```

---
*Zzzzt! Managed with the help of Rotom.*
