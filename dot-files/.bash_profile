EDITOR=vim; export EDITOR
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias ls='ls -GFh'
alias grep='grep --color=auto'
PS1_OLD=${PS1}
export PS1='\[\033[1;34m\]\!\[\033[0m\] \[\033[1;35m\]\u\[\033[0m\]:\[\033[1;35m\]\W\[\033[0m\] \[\033[1;92m\]\[\033[0m\]$ '

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi