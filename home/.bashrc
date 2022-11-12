# helper
alias bb='. ~/.bashrc'

# prompt
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/^\* *//' -e 's/^/ /'
}

PS1='\n\e[30;44m\u@\h \w\e[40;34m $(git_branch)\e[m\e[30m\e[m\n$ '

# git
alias gl='git lol -20'
alias gf='git ft'
alias gs='git status'
alias gm='git merge'
alias gp='git pull -p'
alias ga='git cm --amend --no-edit'
alias gsh='git push'
alias gd='git diff'
# alias wl='git worktree list'
# alias wn='~/scripts/new-worktree.sh'
# alias wa='~/scripts/add-worktree.sh'
# alias wr='~/scripts/remove-worktree.sh'
