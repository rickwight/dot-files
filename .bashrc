#!/bin/bash

#### Local configuration

if [ ~/.localrc ]; then
  . ~/.localrc
fi

#### Aliases

# apps
alias go="xdg-open 2>/dev/null"
alias vi=vim
alias rd="rdesktop -g 800x600"

# my apps
alias gr="~/git/scratch/gr"

# posix stuff
alias grep="grep --color"
alias ff="find -type f | sort"
alias fd="find -type d | sort"
alias fn="find . -name"
alias ls="ls --color=auto"
alias la="ls -lath --color=auto"
alias ll="ls -lah --color=auto"

# git
alias gs="git status"
alias ga="git add"
alias gc="git checkout"
alias gb="git branch"
alias gba="git branch -a"
alias gk="gitk --all &"
alias gl="git log"
alias gcp="git cherry-pick"
alias gd="git diff"
alias gf="git diff-tree --no-commit-id --name-only -r"

# Set terminal title
function set_term_title {
  dir=$1
  dir=${dir: -20}
  echo -en "\033]2;$dir\007"
}

# Over cd to set terminal title
function cd {
  dir=$1
  if [ -z "$dir" ]
    then dir=~
  fi
  builtin cd "$dir" && set_term_title `pwd`
}

# Current git branch or nothing.
function git_branch {
  local ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

# What to display as prompt suffix in Bash. Most sensibly represented as '$'.
function _prompt_suffix {
  echo '$'
}

function _shortpath {
  #   How many characters of the $PWD should be kept
  local pwd_length=50
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
  local branch_name=`git_branch`
  if [ -n "$branch_name" ]; then
    echo " $branch_name"
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
BOLD_GREY="1;33m\]"
BOLD_ORANGE="1;31m\]"
BLUE="0;34m\]"
START="\[\e["
STOP="\[\e[m\]"
PROMPT_COMMAND='RET=$?;'
STATUS="\$(__a=\$?;if ((\$__a)); then echo -n \$__a && echo -n ' '; fi)"
export PROMPT_COMMAND='PS1="$START$RED$STATUS$STOP\u@\h $START$WHITE\w$STOP\$(_git_branch_ps1) $START$BLUE$(_prompt_suffix)$STOP "'
