alias la='ls -a'
alias ll='ls -la'
PS1='\[\e[1;30m\]\t $(git branch &> /dev/null; \
  if [ $? -eq 0 ]; then \
    echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
      if [ "$?" -eq "0" ]; then \
        echo "\[\e[1;32m\]$(__git_ps1 "[%s]")"; \
      else \
        echo "\[\e[1;31m\]$(__git_ps1 "[%s]")"; \
    fi) $(if [[ $(git remote) ]]; then \
      echo `git status` | grep "Your branch is up-to-date" > /dev/null 2>&1; \
      if [ "$?" -eq "0" ]; then \
        echo "\[\e[1;32m\][$(git remote)]"; \
      else \
        echo "\[\e[1;31m\][$(git remote)]"; \
      fi \
    fi) "; \
fi)\[\e[1;36m\][\w] \[\e[0m\]$ '
