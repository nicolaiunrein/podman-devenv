autoload -Uz vcs_info
setopt PROMPT_SUBST

# Enable git backend
zstyle ':vcs_info:*' enable git

# Branch + dirty marker
zstyle ':vcs_info:git:*' formats '(%b%m)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%m)'
zstyle ':vcs_info:git:*' stagedstr ' *'
zstyle ':vcs_info:git:*' unstagedstr ' *'

git_stats() {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  local adds dels changes staged
  adds=$(git diff --numstat | awk '{a+=$1} END{print a+0}')
  dels=$(git diff --numstat | awk '{d+=$2} END{print d+0}')
  changes=$(git diff --name-only | wc -l | tr -d ' ')
  staged=$(git diff --cached --name-only | wc -l | tr -d ' ')
  echo "[+${adds} -${dels}] ${changes} changes ${staged} added"
}

precmd() {
  vcs_info
}

PROMPT='%~ ${vcs_info_msg_0_} $(git_stats)
> '
