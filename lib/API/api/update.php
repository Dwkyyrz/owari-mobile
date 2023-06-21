<?php

// Menghubungkan ke database MySQL
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "owari"; // Ganti dengan nama database yang sesuai

$conn = new mysqli($servername, $username, $password, $dbname);

// Memeriksa koneksi database
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Mengambil data yang dikirim melalui form-data
$u_id = $_POST['u_id'];
$username = $_POST['username'];
$email = $_POST['email'];
$password = $_POST['password'];
$telp = $_POST['telp'];
$alamat = $_POST['alamat'];
$tipe = $_POST['tipe'];

// Memperbarui profil pengguna kecuali jika tipe pengguna adalah "admin"
if ($tipe !== 'admin') {
    $sql = "UPDATE user SET username='$username', email='$email', password='$password', telp='$telp', alamat='$alamat' WHERE u_id='$u_id' AND tipe='user'";

    if ($conn->query($sql) === TRUE) {
        $response = array("status" => "success", "message" => "Profil berhasil diperbarui");
    } else {
        $response = array("status" => "error", "message" => "Gagal memperbarui profil: " . $conn->error);
    }
} else {
    $response = array("status" => "error", "message" => "Tidak diizinkan untuk memperbarui profil admin");
}

// Menutup koneksi database
$conn->close();

// Mengirimkan response dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);

?>
