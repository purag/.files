alias ls='ls -GF'
alias ll='ls -la'
alias grep='grep --color=auto'

__green="\e[1;32m"
__red="\e[1;31m"
__gray="\e[1;30m"
__blue="\e[1;34m"
__magenta="\e[1;35m"
__reset="\e[0m"

source ~/.vim/plugged/fzf/shell/completion.bash
source ~/.vim/plugged/fzf/shell/key-bindings.bash

git_prompt () {
  if git branch &> /dev/null; then
    local branchinfo=$(git branch -vv | grep "^*")
    local loc_branch=$(cut -d" " -f2 <<< $branchinfo)
    local rem_branch=$(cut -d" " -f4 <<< $branchinfo | cut -d[ -f2 | cut -d: -f1)

    local loc_hash=$(git rev-parse @ 2> /dev/null)
    local rem_hash=$(git rev-parse @{u} 2> /dev/null)
    local base_hash=$(git merge-base @ @{u} 2> /dev/null)

    # up-to-date
    if [[ -z $rem_hash ]] || [ $loc_hash = $rem_hash ]; then
      # nothing to commit
      if [[ -z $(git status -s) ]]; then
        echo "$__green[$loc_branch]"
      # but uncommitted local changes
      else
        echo "$__red[$loc_branch]"
      fi

    # need to pull
    elif [ $loc_hash = $base_hash ]; then
      echo "$__red[$loc_branch $__green<- $rem_branch]"
    
    # need to push
    elif [ $rem_hash = $base_hash ]; then
      echo "$__green[$loc_branch $__red-> $rem_branch]"
    
    # diverged
    else
      echo "$__red[$loc_branch -><- $rem_branch]"
    fi
  fi
}

show_input_prompt () {
  
  if [ "$EUID" -eq 0 ]; then
    echo "# ";
  else
    echo "$ ";
  fi;
}

show_remote_host () {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "@$(hostname)";
  fi;
}

my_prompt () {
#   local status=$?
#   if [ $status != 0 ]; then
#     local __inputcolor="$__red"
#   else
  local __inputcolor="$__reset"
#   fi
  PS1="$__gray\t $__magenta[\u$(show_remote_host)$__reset : $__blue\w] $(git_prompt)$__inputcolor\n$(show_input_prompt)$__reset"
}

PROMPT_COMMAND=my_prompt
