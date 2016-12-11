apt update -y
apt install mysql -y
apt install ruby -y
apt install git -y
wget http://dev.mysql.com/get/mysql-apt-config_0.8.0-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.0-1_all.deb
sudo apt update -y
sudo apt install mysql-server -y
sudo apt-get install ruby-dev -y
apt-get install libmysqlclient-dev -y
sudo service mysql status
sudo service mysql start
cd /
ls
cd var/
ls
mkdir www
cd www/
