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

# Crea la tabella 'test'
sudo mysql -e "USE $DB_NAME; CREATE TABLE IF NOT EXISTS test (id INT AUTO_INCREMENT PRIMARY KEY, messaggio VARCHAR(255));"

# Permette connessioni da web


#  generato dall'ia
# La prima linea usa sed (strumento per modificare file di testo), si occupa di
# cambiare il valore di bind-address a 0.0.0.0, permettendo a MariaDB di accettare connessioni da qualsiasi indirizzo IP (non solo da localhost).

# -i: dice a sed di modificare il file direttamente (in-place).
# "s/^bind-address.*/bind-address = 0.0.0.0/": questa è l’istruzione di sostituzione:
#   - s/…/…/ significa “sostituisci… con…”.
#   - bind-address.* cerca una riga che inizia con bind-address e qualsiasi cosa dopo.
#   - bind-address = 0.0.0.0 è il nuovo testo che sostituirà la riga trovata.
#   - /etc/mysql/mariadb.conf.d/50-server.cnf: è il file di configurazione di MariaDB che viene modificato.

sudo sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb
