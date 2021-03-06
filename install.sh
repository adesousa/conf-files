#!/bin/sh

#Version v1.3.2
#Script d’installation d’un nouvel environnement Debian-based (install.sh)
#Exécuter ce script en root, sinon cela ne fonctionne pas.
#Pour plus d'optimisations système lire ici : http://doc.ubuntu-fr.org/optimisation
#Pour une meilleure configuration d'un serveur web lire ici : http://blog.nas-admin.org/?p=25

# On se place sur le dossier de dev pour effectuer ces commandes
cd /Data/Linux/2-Dev/

echo "# Création d'un fichier de log pour tracer les opérations d'installation" > ./log_install_dd.txt

read -p "Avant de continuer l'installation, récuperer la clé SSH pour github : suivre la procédure de keygen-ssh de github"
echo "Install git + git clone de mon repo adesousa"
sudo apt-get install -qq -y git
git clone git@github.com:adesousa/conf-files.git conf-files

echo "# Installation de VIM" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y vim | tee -a ./log_install_dd.txt

echo "# Installation de Guake (dropdown terminal), pensez à remplacer le raccourci F12 par 2 superio" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y guake | tee -a ./log_install_dd.txt

echo "# Mise à jour des paquets du nouvel OS installé (apt-get update + upgrade)" | tee -a ./log_install_dd.txt
sudo apt-get update -qq | tee -a ./log_install_dd.txt
sudo apt-get upgrade -qq | tee -a ./log_install_dd.txt


echo "# Installation des services nécessaires" | tee -a ./log_install_dd.txt
echo "# Installation de Nginx: Linux Nginx Mysql Php (LNMP) + PHP5-fpm" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y nginx php5-fpm | tee -a ./log_install_dd.txt
sudo cp -r conf-files/nginx/* /etc/nginx/
echo "# On ajoute un lien symbolique de sites-available vers sites-enabled pour rendre les sites accessibles" | tee -a ./log_install_dd.txt
sudo ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enabled/ | -a ./log_install_dd.txt
echo "# Paramétrage des dossiers www + Reload de la conf du serveur après la mise à jour de la conf" | tee -a ./log_install_dd.txt
sudo mkdir /var/www/errors/global/ | tee -a ./log_install_dd.txt
sudo cp /var/run/nginx/www/50x.html /var/www/errors/global/50x.html | tee -a ./log_install_dd.txt
sudo /etc/init.d/nginx reload | tee -a ./log_install_dd.txt


echo "# Installation de Mysql et de son extension php" | tee -a ./log_install_dd.txt
sudo apt-get install mysql-server php5-mysql -qq -y | tee -a ./log_install_dd.txt


echo "# Installation des extensions php nécessaires au développement php" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-ming php5-ps php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl | tee -a ./log_install_dd.txt


echo "# Installation de APC" | tee -a ./log_install_dd.txt
sudo apt-get install php-apc -qq -y | tee -a ./log_install_dd.txt
echo 'apc.shm_size=100' >> /etc/php5/fpm/conf.d/apc.ini


echo "# Installation de Memcached et de son extension php5" | tee -a ./log_install_dd.txt
sudo apt-get install memcached php5-memcache -qq -y | tee -a ./log_install_dd.txt


echo "# Installation de capifony" | tee -a ./log_install_dd.txt
apt-get install rubygems -qq -y | tee -a ./log_install_dd.txt
gem install capifony | tee -a ./log_install_dd.txt


echo "# Installation et reconfiguration de phpmyadmin"  | tee -a ./log_install_dd.txt
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
sudo chmod 777 ./start_server_web.sh | tee -a ./log_install_dd.txt


echo "# Installation de curl et de composer.phar" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y curl | tee -a ./log_install_dd.txt
sudo curl -s http://getcomposer.org/installer | php -- --install-dir=/usr/bin


echo "# Installation de nodeJs et less" | tee -a ./log_install_dd.txt
sudo apt-get install python-software-properties -qq -y | tee -a ./log_install_dd.txt
sudo apt-add-repository ppa:chris-lea/node.js
sudo apt-get update -qq > /dev/null
sudo apt-get install -qq -y nodejs npm | tee -a ./log_install_dd.txt
sudo npm install -g less | tee -a ./log_install_dd.txt


echo "# Configuration de git" | tee -a ./log_install_dd.txt
sudo cp conf-files/git/.git* /root/ | tee -a ./log_install_dd.txt
sudo cp conf-files/git/.git* /home/adesousa/ | tee -a ./log_install_dd.txt


echo "################# Installations diverses ################" | tee -a ./log_install_dd.txt

#echo "# Installation de Spotify" | tee -a ./log_install_dd.txt
#echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59
#sudo apt-get update -qq > /dev/null
#sudo apt-get install -qq -y spotify-client | tee -a ./log_install_dd.txt


echo "Copie de la doc symfony2 compilée avec Sphynx" | tee -a ./log_install_dd.txt
sudo cp -r conf-files/symfony/ ./ | tee -a ./log_install_dd.txt


echo "Configuration des .dot-files pour bash" | tee -a ./log_install_dd.txt
sudo cp conf-files/dot-files/.bash_aliases /root/ | tee -a ./log_install_dd.txt
sudo cp conf-files/dot-files/.bash_aliases /home/adesousa/ | tee -a ./log_install_dd.txt


echo "# Installation de preload pour l'amélioration des performances" | tee -a ./log_install_dd.txt
sudo apt-get install -qq -y preload | tee -a ./log_install_dd.txt


echo "# Forcer l’utilisation de la mémoire vive au dépend du swap" | tee -a ./log_install_dd.txt
sudo echo "vm.swappiness = 10" >> /etc/sysctl.conf | tee -a ./log_install_dd.txt


echo "# Désactiver apport (service de remontée de bugs)" | tee -a ./log_install_dd.txt
sudo sed -i -e s/enabled=1/enabled=0/g /etc/default/apport


echo "# Installation de Compiz Config Settings Manager, Unity tweak tools et ubuntu-tweak, pour gérer les paramètres d'ubuntu" | tee -a ./log_install_dd.txt
sudo apt-get install compizconfig-settings-manager unity-tweak-tool -qq -y | tee -a ./log_install_dd.txt
sudo add-apt-repository -y ppa:tualatrix/ppa | tee -a ./log_install_dd.txt
sudo apt-get update -qq > /dev/null
sudo apt-get install ubuntu-tweak -qq | tee -a ./log_install_dd.txt


echo "# Désinstallation de quelques services ou logiciels non nécessaires" | tee -a ./log_install_dd.txt
echo "# Remove Apache2 et Lighttpd pour éviter les conflits avec les différents serveurs web existants sur le poste" | tee -a ./log_install_dd.txt
sudo apt-get remove -qq -y --purge apache2 | tee -a ./log_install_dd.txt
sudo apt-get remove -qq -y --purge lighttpd | tee -a ./log_install_dd.txt
sudo rm -r /etc/init.d/apache2 | tee -a ./log_install_dd.txt


echo "# Suppression des services mysql,Nginx, php5, rsync, bluetooth et Apache2 (qui vient d'être supprimé) au démarrage" | tee -a ./log_install_dd.txt
sudo update-rc.d -f mysql remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f apache2 remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f nginx remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f php5-fpm remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f bluetooth remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f rsync remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f pppd-dns remove | tee -a ./log_install_dd.txt
sudo update-rc.d -f pcmciautils remove | tee -a ./log_install_dd.txt
# sudo update-rc.d -f speech-dispatcher remove | tee -a ./log_install_dd.txt : A tester avant de supprimer du démarrage...


echo "# Chown de /var/www pour que Nginx puisse lire comme il se doit dans les dossiers web et éviter des pb de droits" | tee -a ./log_install_dd.txt
chown -R www-data:www-data /var/www | tee -a ./log_install_dd.txt


echo "# Purger l'ensemble des fichiers de configurations suites aux installations - désinstallations" | tee -a ./log_install_dd.txt
sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep "^rc" | tr -s ' ' | cut -d ' ' -f 2)  | tee -a ./log_install_dd.txt

echo "Install git + git clone de mon repo adesousa"
sudo apt-get install -qq -y git
git clone git@github.com:adesousa/conf-files.git conf-files

read -p "Avant de continuer l'installation, récuperer les clés SSH pour github et assembla qui permettront de se connecter aux différents projets existants"
echo "# Configuration des projets et autres éléments" | tee -a ./log_install_dd.txt
sudo mkdir Workspaces
cd Workspaces
svn checkout http://svn2.xp-dev.com/svn/ppc ppc1.4
svn checkout http://svn2.xp-dev.com/svn/vivalur vivalur
git clone git@git.assembla.com:code-chouchou.git chouchou
git clone git@git.assembla.com:lusidade.git lusidade
git clone git@github.com:odolbeau/ppc.git ppc
ln -s /home/adesousa/Bureau/Workspaces/* /var/www/
# Config of ppc project
cd /home/adesousa/Bureau/Workspaces/ppc
cp app/config/parameters-dist.yml parameters.yml
composer.phar install
cd /home/adesousa/Bureau
echo "Penser à récuperer le script amazon et sa clé ssh"

read -p "Penser à importer le fichier de conf compiz notamment pour les raccourcis et comportement des fenêtres"

echo "Installation done: Reboot to enjoy the power!"

#
# Deprecated car logiciels plus nécessaire dans les nouvelles versions ou je m'en sers plus...
#
#
# echo "# Installation de laptop-mode-tools pour l'amélioration des performances sur un portable" | tee -a ./log_install_dd.txt
# sudo apt-get install -qq -y laptop-mode-tools | tee -a ./log_install_dd.txt
#
#echo "# Installation de powertop pour améliorer la batterie (lancer powertop > onglet tunab et tout passer à GOOD + commande powertop --calibrate)" | tee -a ./log_install_dd.txt
#sudo apt-get install -qq -y powertop | tee -a ./log_install_dd.txt
#
#echo "# Installation de Gedit et de quelques plugins" | tee -a ./log_install_dd.txt
#sudo apt-get install -qq -y gedit | tee -a ./log_install_dd.txt
#sudo apt-get install -qq -y gedit-plugins | tee -a ./log_install_dd.txt
#sudo apt-add-repository -y ppa:ubuntu-on-rails/ppa
#sudo add-apt-repository ppa:gedit-bc-dev-plugins/releases
#sudo apt-get update -qq > /dev/null
#sudo apt-get install -qq -y gedit-gmate exuberant-ctags | tee -a ./log_install_dd.txt
#sudo apt-get install -qq -y dconf-tools | tee -a ./log_install_dd.txt
#sudo apt-get install python-gi-cairo -qq -y | tee -a ./log_install_dd.txt
#sudo apt-get install gedit-classbrowser3g
#
# installation de plusieurs plugins: vigedit, tabSwitcher ...
#mkdir -p ~/.local/share/gedit/plugins/
#sudo cp -r conf-files/gedit/plugins/* ~/.local/share/gedit/plugins/
#sudo cp conf-files/gedit/twig.lang /usr/share/gtksourceview-3.0/language-specs/ | tee -a ./log_install_dd.txt
#sudo dconf load /org/gnome/gedit/ < conf-files/gedit/gedit.settings | tee -a ./log_install_dd.txt
#sudo cp -r /root/.config/dconf /home/adesousa/.config/ | tee -a ./log_install_dd.txt
#
#### S'il y a des changements dans la conf gedit : voici une méthode pour regénerer un dump des settings de gedit
#sudo dconf dump /org/gnome/gedit/ > gedit.settings
#sudo dconf load /org/gnome/gedit/ < gedit.settings
#sudo cp -r /root/.config/dconf /home/adesousa/.config/
#
#echo "# Installation des différents bureaux Mint sous linux ou debian, ya plus qu'à choisir au démarrage celui que je préfère" | tee -a ./log_install_dd.txt
#sudo add-apt-repository ppa:webupd8team/gnome3 | tee -a ./log_install_dd.txt
#sudo add-apt-repository --yes ppa:gwendal-lebihan-dev/cinnamon-stable | tee -a ./log_install_dd.txt
#sudo apt-get update -qq | tee -a ./log_install_dd.txt
#sudo apt-get install -qq -y gnome-shell gnome-session gnome-session-fallback gnome-tweak-tool cinnamon muffin | tee -a ./log_install_dd.txt
# facultatifs mais jolies...
#sudo apt-get install -qq -y cinnamon-extensions-extended-places-menu | tee -a ./log_install_dd.txt
#sudo apt-get install -qq -y cinnamon-extension-weather cinnamon-extensions-system-monitor | tee -a ./log_install_dd.txt
#sudo add-apt-repository ppa:webupd8team/gnome3 | tee -a ./log_install_dd.txt
#sudo apt-get update -qq | tee -a ./log_install_dd.txt
#sudo apt-get install -qq -y gnome-shell gnome-session mgse-bottompanel mgse-menu mgse-windowlist gnome-tweak-tool | tee -a ./log_install_dd.txt
#
# Installation de phpunit pour Symfony2
#sudo pear upgrade PEAR  | tee -a ./log_install_dd.txt
#pear config-set auto_discover 1 | tee -a ./log_install_dd.txt
#pear install pear.phpunit.de/PHPUnit | tee -a ./log_install_dd.txt
#
#echo "# Installation de subversion" | tee -a ./log_install_dd.txt
#sudo apt-get install -qq -y subversion | tee -a ./log_install_dd.txt
#
#echo "# Installation de Google Chrome" | tee -a ./log_install_dd.txt
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - | tee -a ./log_install_dd.txt
#sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' | tee -a ./log_install_dd.txt
#sudo apt-get update -qq > /dev/null
#sudo apt-get install -qq -y google-chrome-stable | tee -a ./log_install_dd.txt
#echo "# Installation de rhytmbox" | tee -a ./log_install_dd.txt
#sudo apt-get install -qq -y rhythmbox | tee -a ./log_install_dd.txt
#
#echo "# Installation de Netbeans pour php - Méthode via l'installeur depuis leur site qui fonctionne mieux que l'apt-get..." | tee -a ./log_install_dd.txt
#sudo apt-get install -qq -y openjdk-7-jre | tee -a ./log_install_dd.txt
#wget http://bits.netbeans.org/netbeans/7.1/community/latest/bundles/netbeans-7.1-ml-php-linux.sh | tee -a ./log_install_dd.txt
#sh netbeans-7.1-ml-php-linux.sh  | tee -a ./log_install_dd.txt
#sudo cp -r conf-files/netbeans/ ./ | tee -a ./log_install_dd.txt
