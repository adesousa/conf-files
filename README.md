conf-files
=========
This my all-in-one installation pack for a new linux debian-based installation.

Setup a new linux
-----

    cd ~
    git clone http://github.com/adesousa/conf-files.git
    
Setup of dot-files
-----

    cd ~
    ln -s conf-files/.bash_aliases   .bash_aliases
    ln -s conf-files/.bash_profile   .bash_profile
    ln -s conf-files/.gitconfig      .gitconfig
    ln -s conf-files/.gitignore      .gitignore
    ln -s conf-files/.netbeans       .netbeans
    
Setup conf-files of a linux debian based (Ubuntu, debian, ...)
-----

    cd ~
    sh install.sh

Setup netbeans coloration 
-----
Start Netbeans and apply the zip, it contains the syntaxic coloration for symfony and my own shortcuts.
