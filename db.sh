#ferma lo script in caso di errore
set -e


sudo apt-get update -y

# MariaDB
sudo apt-get install -y mariadb-server

sudo systemctl enable mariadb
sudo systemctl start mariadb


DB_NAME="m340db"
DB_USER="m340user"
DB_PASS="m340pass"

sudo mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
sudo mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Permette connessioni da web
sudo sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb
