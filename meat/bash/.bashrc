# better colors
# previously `solarized-dark`
eval `dircolors ~/.files/meat/bash/dircolors/monokai`

# smarter ls & grep
alias ls='ls -GF'
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
  if test -f "$PWD/.gitpromptignore"; then
    return
  fi

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
    echo "${__violet}on $(hostname) "
  fi
}

my_prompt () {
  # save and reload history after each command finishes
  history -a; history -c; history -r;
  PS1="\[$__dark_gray\]\t $(show_remote_host)\[${__cyan}\]in \w $(git_prompt)\n\[$__orange\]\u\[$__reset\] › "
}

# preserve history across all shells
HISTCONTROL=ignoredups:erasedups
HISTSIZE=999999
HISTFILESIZE=999999
shopt -s histappend

PROMPT_COMMAND=my_prompt

# source any local $PATH additions
source ~/.files/meat/bash/paths

# source custom bash functions
source ~/.files/meat/bash/functions

# set terminal color scheme
__reset="$(tput sgr 0)"
scheme pur firamono &> /dev/null

# source any local configs
[ -f ~/.bash_local ] && source ~/.bash_local

export GPG_TTY=$(tty)

# link this file in ~
# purag/.files!link

# Set the Hi status to be displayed as part of the prompt. #!>>HI<<!#
# PS1="\[\${__hi_prompt_color}\]\${__hi_prompt_text}\[${__hi_NOCOLOR}\]${PS1}" #!>>HI<<!#
# Set the default values for the text of the hi prompt. Change these if you like. #!>>HI<<!#
# __hi_on_prompt="[hi on] " #!>>HI<<!#
# __hi_off_prompt="[hi off] " #!>>HI<<!#

