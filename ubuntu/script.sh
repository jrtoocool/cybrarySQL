cd /ho	USER='root'
PASSWORD='CybraryIT'

sudo apt-get -y update
mkdir laravel
sudo apt-get -y install php php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip php-cli php-mysql php-bcmath php-imap openssl
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
composer create-project --prefer-dist laravel/laravel laravel




wget "https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb"
export DEBIAN_FRONTEND=noninteractive
sudo yes | dpkg -i mysql-apt-config_0.8.13-1_all.deb
sudo apt-get -y update
sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password $PASSWORD"
sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password $PASSWORD"
sudo debconf-set-selections <<< "mysql-community-server mysql-server/default-auth-override select Use Legacy Authentication Method (Retain MySQL 5.x Compatibility)"
sudo apt-get -y install mysql-server 
sudo mysql -u "$USER" -p"$PASSWORD" -e "CREATE USER '$USER'@'%' IDENTIFIED BY '$PASSWORD';"
sudo mysql -u "$USER" -p"$PASSWORD" -e "GRANT ALL PRIVILEGES ON *.* TO '$USER'@'%' WITH GRANT OPTION;"