# ==========================================
# Homebrew Bundle - Full Development Suite
# ==========================================
# Installed auto trigger on chezmoi apply via script: .chezmoiscripts/run_onchange_before_install-packages.sh
# ==========================================

#--- Runtime manager ---
# Development toolchains and CLIs (node, go, rust, uv, fzf, ripgrep, tmux, ...)
# are managed by mise: see dot_config/mise/config.toml. Keep a tool here only
# when mise's registry lacks it or it must be on the global PATH.
brew "mise"          # Runtime version manager

#--- Git and integrations ---
# git invokes these directly (also from GUI clients that never see mise's PATH),
# and `gh auth setup-git` writes gh's absolute path into the git config.
brew "git"           # Version control
brew "git-delta"     # Syntax-highlighting pager for git and diff
brew "git-flow-next" # Modern implementation of Git-flow
brew "git-lfs"       # Versioning large files
brew "git-open"      # Open GitHub webpages from terminal
brew "gh"            # GitHub CLI

#--- Not in the mise registry ---
brew "try-rs"        # Temporary experiment workspace manager
brew "mole"          # Deep clean and optimize your Mac

# Casks — fonts & terminal
cask "font-maple-mono-nf-cn"
cask "ghostty"
cask "zed"

# Casks — apps & CLIs
cask "1password-cli"
cask "chatgpt"
cask "claude-code@latest"
cask "codex"
cask "orbstack"
