<?php
// $servername = "localhost";
// $username = "root";
// $password = "";
// $database = "owari";
$servername = "localhost";
$username = "id20870607_db_owari";
$password = "Owari_1000";
$database = "id20870607_db_owari";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}
?>
