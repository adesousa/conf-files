# ls aliases
alias ll='ls -lh'
alias la='ls -ahl'
alias v='vim'
alias g='gedit'
alias bureau='cd /home/adesousa/Bureau/'
alias web='cd /var/www/'
alias chouchou='cd /var/www/chouchou/'
alias ppc='cd /var/www/ppc/'
alias lusidade='cd /var/www/lusidade/'

# sf1.4
alias scc1='php symfony cc'
alias sccp1='scc --env=prod'
alias sccd1='scc --env=dev'
alias sfassets1='php symfony plugin:publish:assets'
alias sfdoctrinerebuild1='php symfony doctrine:build --all --and-load --no-confirmation'

# sf2
alias scc='php app/console cache:clear'
alias sccp='scc --env=prod'
alias scct='scc --env=test'
alias sfassets='php app/console assets:install web --symlink'
alias sfdoctrinerebuild='php app/console doctrine:database:drop --force; php app/console doctrine:database:create; php app/console doctrine:schema:create'
