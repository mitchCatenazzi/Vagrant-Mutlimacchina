<?php
$servername = "10.10.20.11";
$username = "m340user";
$password = "m340pass";
$dbname = "m340db";

// Connessione
$conn = new mysqli($servername, $username, $password, $dbname);

// Controllo
if ($conn->connect_error) {
    die("Connessione fallita: " . $conn->connect_error);
} else {
    echo "<h1>Connessione al DB riuscita </h1>";
}

// Creiamo una tabella di test se non esiste
$conn->query("CREATE TABLE IF NOT EXISTS test (id INT AUTO_INCREMENT PRIMARY KEY, msg VARCHAR(255))");

// Inseriamo un record
$conn->query("INSERT INTO test (msg) VALUES ('Ciao da Vagrant!')");

// Leggiamo i record
$result = $conn->query("SELECT * FROM test");

echo "<ul>";
while ($row = $result->fetch_assoc()) {
    echo "<li>" . $row["id"] . ": " . $row["msg"] . "</li>";
}
echo "</ul>";

$conn->close();
?>
