_exe_hosts() {
    reply=(${(f)"$(ssh exe.dev ls --json 2>/dev/null | jq -r '.vms[].ssh_dest')"})
}

zinit ice wait"0b" lucid id-as"_execompletions" atload'
    zstyle -e ":completion:*:(ssh|scp|rsync):*" hosts "_exe_hosts"
    zpcompinit; zpcdreplay'
zinit light zdharma-continuum/null
