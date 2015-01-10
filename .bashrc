#!/bin/bash

#### Aliases

# apps
alias go=xdg-open
alias vi=vim
alias rd="rdesktop -g 800x600"

# my apps
alias gr="~/git/scratch/gr"

# posix stuff
alias grep="grep --color"
alias ff="find -type f | sort"
alias fd="find -type d | sort"
alias fn="find . -name" 
alias la="ls -lath"

# git
alias gs="git status"
alias ga="git add"
alias gc="git checkout"
alias gb="git branch"
alias gba="git branch -a"
alias gk="gitk --all &"
alias gl="git log"
alias gcp="git cherry-pick"

# Current git branch or nothing.
function br {
  local ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

# What to display as prompt suffix in Bash. Most sensibly represented as '$'.
function _prompt_suffix {
  echo '$ '
}

function _shortpath {
  #   How many characters of the $PWD should be kept
  local pwd_length=30
  local canonical=`pwd -P`
  local lpwd="${canonical/#$HOME/~}"
  if [ $(echo -n $lpwd | wc -c | tr -d " ") -gt $pwd_length ]
    then newPWD="...$(echo -n $lpwd | sed -e "s/.*\(.\{$pwd_length\}\)/\1/")"
    else newPWD="$(echo -n $lpwd)"
  fi
  echo $newPWD
}

# Display current branch in PS1.
function _git_branch_ps1 {
  local branch_name=`br`
  if [ -n "$branch_name" ]; then
    echo "($branch_name)"
  else
    return  # Not a git repo.
  fi
}

# Taken from http://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
# Also read this: http://superuser.com/questions/246625/bash-command-prompt-overwrites-the-current-line
# Use the start and stop tokens to define a period of time for color to be activated.
WHITE="0;37m\]"
YELLOW="0;33m\]"
GREEN="0;32m\]"
RED="0;31m\]"
START="\[\e["
STOP="\[\e[m\]"
PROMPT_COMMAND='RET=$?;'
RET_VALUE='$(echo $RET)'
# export PROMPT_COMMAND='PS1="\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\!] $START$YELLOW\u@\h:$STOP $START$WHITE\$(shortpath)$STOP$START$RED\$(parse_git_branch)$STOP $(prompt_suffix)"'
export PROMPT_COMMAND='PS1="$START$WHITE\$(_shortpath)$STOP$START$RED\$(_git_branch_ps1)$STOP $START$YELLOW$(_prompt_suffix)$STOP"'
