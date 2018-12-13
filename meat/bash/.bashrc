# better colors
eval `dircolors ~/.files/meat/bash/dircolors/solarized-dark`

# smarter ls & grep
alias ls='ls -GF --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'
# make tmux great again
alias tmux="TERM=screen-256color-bce tmux"

# default editor = vim
export EDITOR=vim

# source fzf bash helpers
source ~/.vim/plugged/fzf/shell/completion.bash
source ~/.vim/plugged/fzf/shell/key-bindings.bash

git_prompt () {
  if command git branch &> /dev/null; then
    if ! command git log &> /dev/null; then
      echo -ne "${__reset}with ${__green}a fresh new repo initialized"
      return
    fi

    local branch=$(command git rev-parse --abbrev-ref HEAD)
    local changed=$(command git ls-files --modified | wc -l)
    local staged=$(command git diff --cached --numstat | wc -l)
    local untracked=$(command git ls-files --others --exclude-standard | wc -l)

    echo -ne "${__reset}with "
    if (( changed )); then
      echo -ne "$__yellow$changed changed"
    fi
    if (( staged )); then
      (( changed )) && echo -n ", "
      echo -ne "$__orange$staged staged"
    fi
    if (( untracked )); then
      (( changed )) || (( staged )) && echo -n ", "
      echo -ne "$__red$untracked untracked"
    fi
    if (( ! changed )) && (( ! staged )) && (( ! untracked )); then
      echo -ne "${__green}nothing to do"
    fi

    echo -e " ${__reset}on $branch"
  fi
}

show_remote_host () {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "${__magenta}on $(hostname) "
  fi
}

my_prompt () {
  PS1="\[$__gray\]\t $(show_remote_host)\[${__cyan}\]in \w $(git_prompt)\n\[$__orange\]\u\[$__reset\] › "
}

PROMPT_COMMAND=my_prompt

# source any local $PATH additions
source ~/.files/meat/bash/paths

# source custom bash functions
source ~/.files/meat/bash/functions

# set terminal color scheme
__reset="$(tput sgr 0)"
scheme pur inputmono &> /dev/null

# source any local configs
[ -f ~/.bash_local ] && source ~/.bash_local

# link this file in ~
# purag/.files!link
