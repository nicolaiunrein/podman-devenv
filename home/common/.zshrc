export PATH="$PATH;/root/.cargo/bin"

autoload -Uz compinit vcs_info
compinit

setopt PROMPT_SUBST
# ✚●

zstyle ':vcs_info:git*' formats "(%b) %u %c %a %m"
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}-%f'


precmd() {
    vcs_info
}

# PROMPT='%B%(!.#.$)%b '
PROMPT='%F{blue}%~%f # '
RPROMPT='${vcs_info_msg_0_}'
