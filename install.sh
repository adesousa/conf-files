#!/bin/sh

#Version v1.0.0
#Script d’installation d’un nouvel environnement Debian-based (install.sh)
#Exécuter ce script en root, sinon cela ne fonctionne pas.
#Pour plus d'optimisations système lire ici : http://doc.ubuntu-fr.org/optimisation

echo "# Création d'un fichier de log pour tracer les opération d'installation" > ./log_install_dd.txt

echo "# Mise à jour des paquets du nouvel OS installé (apt-get update + upgrade)" | tee -a ./log_install_dd.txt
sudo apt-get update -qq | tee -a ./log_install_dd.txt
sudo apt-get upgrade -qq | tee -a ./log_install_dd.txt

echo "# Installation des services nécessaires" | tee -a ./log_install_dd.txt
echo "# Installation de Nginx: Linux Nginx Mysql Php (LNMP)" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y nginx php5-fpm | tee -a ./log_install_dd.txt

cp -r conf-files/nginx/* /etc/nginx/
echo "# On ajoute un lien symbolique de sites-available vers sites-enabled pour rendre les sites accessibles" | tee -a ./log_install_dd.txt
sudo ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enabled/ &>> -a ./log_install_dd.txt

echo "# Paramétrage des dossiers www + Reload de la conf du serveur après la mise à jour de la conf" | tee -a ./log_install_dd.txt
sudo mkdir /var/www/errors/global/ | tee -a ./log_install_dd.txt
sudo cp /var/run/nginx/www/50x.html /var/www/errors/global/50x.html | tee -a ./log_install_dd.txt
sudo /etc/init.d/nginx reload | tee -a ./log_install_dd.txt

echo "# Installation de php5-fpm (FastCGI Process Manager)" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y php5-fpm | tee -a ./log_install_dd.txt

echo "# Installation des extensions php nécessaires au développement php" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl | tee -a ./log_install_dd.txt

echo "# Installation et reconfiguration de php-my-admin"  | tee -a ./log_install_dd.txt
sudo mkdir /var/www | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y phpmyadmin | tee -a ./log_install_dd.txt
sudo ln -s /usr/share/phpmyadmin /var/www/phpmyadmin | tee -a ./log_install_dd.txt
sed -i -e "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['AllowNoPassword'\]/\$cfg\['Servers'\]\[\$i\]\['AllowNoPassword'\]/g" /etc/phpmyadmin/config.inc.php | tee -a ./log_install_dd.txt

echo "# On crée un fichier phpinfo() pour vérifier l'installation" | tee -a ./log_install_dd.txt
echo "<?php phpinfo(); ?>" > /var/www/phpinfo.php

echo "# Création d’un script de lancement des services mysql + Nginx au même endroit que le script d'installation" | tee -a ./log_install_dd.txt
sudo touch ./start_server_web.sh | tee -a ./log_install_dd.txt
sudo echo "
sudo /etc/init.d/nginx start
sudo /etc/init.d/mysql start
sudo /etc/init.d/php5-fpm start
" >> ./start_server_web.sh
sudo chmod +x ./start_server_web.sh | tee -a ./log_install_dd.txt

echo "# Installation et configuration de git" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y git-core | tee -a ./log_install_dd.txt
sudo git config --global user.name "adesousa" | tee -a ./log_install_dd.txt
sudo git config --global user.email "andre.desousa.95@gmail.com" | tee -a ./log_install_dd.txt

echo "# Installation de ruby, rubygem, capifony..." | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y ruby rdoc ri libreadline-ruby libruby1.8 ruby-dev libssl-dev rubygems rubygems-doc | tee -a ./log_install_dd.txt
sudo gem install -q capifony | tee -a ./log_install_dd.txt
sudo gem install capistrano_rsync_with_remote_cache | tee -a ./log_install_dd.txt

echo "################# Installations diverses ################" | tee -a ./log_install_dd.txt
echo "# Installation de Spotify" | tee -a ./log_install_dd.txt
echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4E9CFF4E | tee -a ./log_install_dd.txt
sudo apt-get update -qq > /dev/null
sudo apt-get install -qq -y spotify-client-qt | tee -a ./log_install_dd.txt

echo "# Installation de rhytmbox" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y rhythmbox | tee -a ./log_install_dd.txt

echo "# Installation de Netbeans pour php - Méthode via l'installeur depuis leur site qui fonctionne mieux que l'apt-get..." | tee -a ./log_install_dd.txt
wget http://bits.netbeans.org/netbeans/7.1/community/latest/bundles/netbeans-7.1-ml-php-linux.sh | tee -a ./log_install_dd.txt
sh netbeans-7.1-ml-php-linux.sh  | tee -a ./log_install_dd.txt
echo "# Penser à installer le plugin netbeans-php qui permet d’envoyer vers le serveur de prod un fichier, ou d’en récupérer."  | tee -a ./log_install_dd.txt

echo "# Installation de Jupiter pour la gestion de l’alimentation d’un pc portable -> ATTENTION, il n'est peut-être pas si efficace que cela si l'on utilise bien powertop !" | tee -a ./log_install_dd.txt
sudo add-apt-repository -y ppa:webupd8team/jupiter &>> ./log_install_dd.txt
sudo apt-get update -qq > /dev/null
sudo apt-get install -qq -y jupiter | tee -a ./log_install_dd.txt

echo "# Installation de VIM" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y vim | tee -a ./log_install_dd.txt

echo "# Installation de preload pour l'amélioration des performances" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y preload | tee -a ./log_install_dd.txt

echo "# Installation de powertop pour améliorer la batterie (lancer powertop > onglet tunab et tout passer à GOOD + commande powertop --calibrate)" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y powertop | tee -a ./log_install_dd.txt

echo "# Installation de laptop-mode-tools pour l'amélioration des performances sur un portable" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y laptop-mode-tools | tee -a ./log_install_dd.txt

echo "# Installation de ubuntu-tweak, pour gérer les paramètres d'ubuntu" | tee -a ./log_install_dd.txt
sudo add-apt-repository -y ppa:tualatrix/next | tee -a ./log_install_dd.txt
sudo apt-get update -qq > /dev/null
sudo apt-get install ubuntu-tweak -qq | tee -a ./log_install_dd.txt

echo "# Désinstallation de quelques services ou logiciels non nécessaires" | tee -a ./log_install_dd.txt
echo "# Remove Apache2 et Lighttpd pour éviter les conflits avec les différents serveurs web existants sur le poste" | tee -a ./log_install_dd.txt
sudo apt-get remove -qq -y --purge apache2 | tee -a ./log_install_dd.txt
sudo rm -r /etc/init.d/apache2 &>> ./log_install_dd.txt

echo "# Suppression des services mysql,Nginx, php5, rsync, bluetooth et Apache2 (qui vient d'être supprimé) au démarrage" | tee -a ./log_install_dd.txt
sudo update-rc.d -f mysql remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f apache2 remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f nginx remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f php5-fpm remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f bluetooth remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f rsync remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f dns-clean remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f pppd-dns remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f pcmciautils remove | tee -a ./log_install_dd.txt
# sudo update-rc.d -f speech-dispatcher remove | tee -a ./log_install_dd.txt : A tester avant de supprimer du démarrage...

echo "# Chown de /var/www pour que Nginx puisse lire comme il se doit dans les dossiers web et éviter des pb de droits" | tee -a ./log_install_dd.txt
chown -R www-data:www-data /var/www | tee -a ./log_install_dd.txt

echo "# Purger l'ensemble des fichiers de configurations suites aux installations - désinstallations" | tee -a ./log_install_dd.txt
sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep "^rc" | tr -s ' ' | cut -d ' ' -f 2)  | tee -a ./log_install_dd.txt

# Installation de phpunit pour Symfony2
sudo pear upgrade PEAR  | tee -a ./log_install_dd.txt
pear config-set auto_discover 1 | tee -a ./log_install_dd.txt
pear install pear.phpunit.de/PHPUnit | tee -a ./log_install_dd.txt

