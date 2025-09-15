<?php
$servername = "10.10.20.11";
$username = "m340user";
$password = "m340pass";
$dbname = "m340db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connessione fallita: " . $conn->connect_error);
} else {
    echo "<h1>Connessione al DB riuscita </h1>";
}

$conn->query("INSERT INTO test (messaggio) VALUES ('ciao dal database!')");
$result = $conn->query("SELECT * FROM test");

echo "<a href='adminer.php' target='_blank' style='background: #28a745; color: #fff'>consultare adminier</a>";

echo "<ul>";
while ($row = $result->fetch_assoc()) {
    echo "<li>" . $row["id"] . ": " . $row["messaggio"] . "</li>";
}
echo "</ul>";



$conn->close();
?>
