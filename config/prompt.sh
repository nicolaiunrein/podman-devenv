
function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty)) /"
}

function parse_git_stat() {
  local o files ins dels
  o=$(git diff --shortstat HEAD 2>/dev/null) || return
  [[ -z $o ]] && return
  files=$(grep -oE '[0-9]+ files? changed' <<<"$o" | grep -oE '^[0-9]+')
  ins=$(grep -oE '[0-9]+ insertions?\(\+\)' <<<"$o" | grep -oE '^[0-9]+'); [[ -z $ins ]] && ins=0
  dels=$(grep -oE '[0-9]+ deletions?\(-\)'  <<<"$o" | grep -oE '^[0-9]+'); [[ -z $dels ]] && dels=0
  adds=$(git status --porcelain . 2>/dev/null | grep -E '^(A|\?\?) ' | wc -l | tr -d ' ')
  local SO=$'\001' SC=$'\002'
  local G="${SO}"$'\e[1;32m'"${SC}"
  local RD="${SO}"$'\e[31m'"${SC}"
  local GR="${SO}"$'\e[90m'"${SC}"
  local R="${SO}"$'\e[0m'"${SC}"
  echo " [${G}+${ins}${R} ${RD}-${dels}${R}] ${GR}${files:-0} changes ${adds:-0} added${R}"
}

# export PS1="\n\t \[\033[32m\]\w\[\033[0m\]\$(parse_git_stat)\n\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ "

# export PS1="hello\n"
# PROMPT="%~"
# PROMPT="%F{8}%~%f :"
PROMPT="%F{cyan}%~%f %F{cyan}>%f"
