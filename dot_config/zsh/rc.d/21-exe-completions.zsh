_exe_hosts() {
    reply=(${(f)"$(ssh exe.dev ls --json 2>/dev/null | jq -r '.vms[].ssh_dest')"})
}

zstyle -e ':completion:*:(ssh|scp|rsync):*' hosts '_exe_hosts'
