#ferma lo script in caso di errore
set -e

sudo apt-get update -y

# installa wget per scaricare Adminer e PHP MySQL extension
sudo apt-get install -y wget

# installa Apache, PHP e l'estensione PHP per MySQL
sudo apt-get install -y apache2 php libapache2-mod-php wget php-mysql

# scarica Adminer nella cartella html settata per apache
sudo wget -O /var/www/html/adminer.php https://www.adminer.org/latest.php

# riavvia Apache
sudo systemctl enable apache2
sudo systemctl restart apache2