# ls aliases
alias ll='ls -lah'
alias la='ls -ahl'
alias v='vim'
alias bureau='cd /Users/andre.desousa/Desktop/'
alias Workspaces=' cd /Users/andre.desousa/Workspaces'
alias web='cd /var/www/'
alias chouchou='cd /var/www/chouchou/'
alias ppc='cd /var/www/ppc/'
alias lusidade='cd /var/www/lusidade/'

alias fuck='sudo $(history -p \!\!)'

# Git
alias g='git'
alias gf='git fetch -p'
alias gfmm='git fetch -p && git merge origin/master'
alias gfrm='git fetch -p && git rebase origin/master'
alias gfr='git fetch -p && git rebase '
alias gp='git pull'
alias gdb='git br -d'

# PHP
alias phptags='ctags -R --PHP-kinds=+cf -f tags.vendors vendor && ctags -R --PHP-kinds=+cf src'

# sf1.4
alias scc1='php symfony cc'
alias sccp1='scc --env=prod'
alias sccd1='scc --env=dev'
alias sfassets1='php symfony plugin:publish:assets'
alias sfdoctrinerebuild1='php symfony doctrine:build --all --and-load --no-confirmation'

# sf2
alias scc='rm -Rf app/cache/*'
alias sfassets='php app/console assets:install web'
alias sfdoctrinerebuild='php app/console doctrine:database:drop --force; php app/console doctrine:database:create; php app/console doctrine:schema:create'
alias sfdoctrinerebuildtest='php app/console doctrine:database:drop --force --env=test; php app/console doctrine:database:create --env=test; php app/console doctrine:schema:create --env=test'
alias sfpu='phpunit --colors -c app'
alias sfpus='sfpu --stop-on-failure'
alias sfpuf='sfpu --filter'
alias sfpud='sfpu --debug'
alias sfcd='php app/console container:debug --show-private'
alias sfcdg='sfcd | grep'
