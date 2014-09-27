echo "----> Iniciando Configuração"

echo "----> Arruma diferença de LOCALE entre o terminal do MAC e o terminal da VM"
echo 'LC_ALL="en_US.UTF-8"' >> /etc/environment

echo "----> Atualizando Linux"
apt-get update && apt-get dist-upgrade

echo "----> Instalando apache"
apt-get install apache2 -y
echo 'ServerName "localhost"' >> /etc/apache2/apache2.conf
a2enmod rewrite

echo "----> Instalando o PHP"
apt-get install php5 libapache2-mod-php5 php5-mcrypt php5-cli -y
rm -rf /etc/php5/apache2/php.ini
ln -s /vagrant/files/php.ini /etc/php5/apache2/php.ini

echo "----> Instalando o PECL"
apt-get install python-software-properties php5-dev -y

echo "----> Instalando o CURL"
apt-get install curl php5-curl -y

echo "----> Instalando o XDEBUG"
pecl install xdebug

echo "----> Instalando GD"
apt-get install php5-gd -y

echo "----> Instalando o MYSQL"
debconf-set-selections <<< 'mysql-server mysql-server/root_password password mysql'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password mysql'
apt-get -y install mysql-server php5-mysql -y
rm -rf /etc/mysql/my.cnf
ln -s /vagrant/files/my.cnf /etc/mysql/my.cnf

echo "----> Arruma privilegios MYSQL"
/etc/init.d/mysql restart
mysql -uroot -pmysql -e "DELETE FROM mysql.user WHERE User='root' AND Host='127.0.0.1';
DELETE FROM mysql.user WHERE User='root' AND Host='::1';
UPDATE mysql.user SET Host='%' WHERE Host='localhost' AND User='root';
FLUSH PRIVILEGES;"

echo "----> Instalando Mongo"
printf "\n"|apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
apt-get update
apt-get install mongodb-org -y
service mongod start
printf "\n"|pecl install mongo

echo "----> Instalando o Memcached"
apt-get install php5-memcached memcached -y
pecl install memcache
echo "extension=memcache.so" | sudo tee /etc/php5/apache2/conf.d/memcache.ini

echo "----> Instalando composer"
curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/bin

echo "----> Instalando GIT"
apt-get install git -y

echo "----> Default virtual host - phpinfo"
cp /vagrant/files/info /var/www -R
rm -rf /var/www/html

echo "----> Adicionando diretorio de Vhosts" 
rm -rf /etc/apache2/sites-enabled
ln -fs /var/www/vhosts /etc/apache2/sites-enabled
cp /vagrant/files/vhosts /var/www/ -R

echo "----> Instalação finalizada !!!"