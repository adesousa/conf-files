# ls aliases
alias ll='ls -lh'
alias la='ls -ahl'
alias v='vim'

# sf1.4
alias scc='php symfony cc'
alias sccp='scc --env=prod'
alias sccd='scc --env=dev'
alias sfassets='php symfony plugin:publish:assets'
alias sfdoctrinerebuild='php symfony doctrine:build --all --and-load --no-confirmation'

# sf2
alias scc='php app/console cache:clear'
alias sccp='scc --env=prod'
alias scct='scc --env=test'
alias sfassets='php app/console assets:install web'
alias sfdoctrinerebuild='php app/console doctrine:database:drop --force; php app/console doctrine:database:create; php app/console doctrine:schema:create'

# cd aliases
alias bureau='/home/adesousa/Bureau'

