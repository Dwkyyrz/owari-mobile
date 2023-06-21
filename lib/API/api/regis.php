<?php
require 'conn.php';
// else {
// echo "Koneksi database sukses";
// }

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $telp = $_POST['telp'];
    $alamat = $_POST['alamat'];

    // Lakukan validasi data jika diperlukan

    $sql = "INSERT INTO user (username, email, password, telp, alamat, tipe) VALUES ('$username', '$email', '$password', '$telp', '$alamat', 'user')";
    // $sql = "INSERT INTO users (username, email, password, telp, alamat) VALUES ('tes', 'tse@s', 'ef', '2', 'wfaw')";

    if ($conn->query($sql) === TRUE) {
        $response['success'] = true;
        $response['message'] = "Registrasi berhasil";
        
    } else {
        $response['success'] = false;
        $response['message'] = "Registrasi gagal: " . $conn->error;
        
    }

    echo json_encode($response);
}

$conn->close();
?>
