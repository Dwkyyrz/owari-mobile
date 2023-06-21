<?php

$host = 'localhost';  
$username = "id20870607_db_owari";
$password = "Owari_1000";
$database = "id20870607_db_owari";

$conn = mysqli_connect($host, $username, $password, $database);

// Mendapatkan data dari permintaan PUT
$data = json_decode(file_get_contents("php://input"), true);

// Mendapatkan nilai-nilai yang ingin diubah
$id = $data['id'];
$username = $data['username'];
$email = $data['email'];
$password = $data['password'];
$telp = $data['telp'];
$alamat = $data['alamat'];

// Memeriksa tipe pengguna sebelum melakukan update
$queryCheckAdmin = "SELECT tipe FROM user WHERE u_id = $id";
$resultCheckAdmin = mysqli_query($conn, $queryCheckAdmin);
$row = mysqli_fetch_assoc($resultCheckAdmin);
$tipe = $row['tipe'];

if ($tipe !== 'admin') {
    // Mengupdate profil pengguna
    $queryUpdateUser = "UPDATE user SET username = '$username', email = '$email', password = '$password', telp = '$telp', alamat = '$alamat' WHERE u_id = $id";
    $resultUpdateUser = mysqli_query($conn, $queryUpdateUser);

    if ($resultUpdateUser) {
        $response = array(
            'status' => 'success',
            'message' => 'Profil pengguna berhasil diperbarui.',
        );
    } else {
        $response = array(
            'status' => 'error',
            'message' => 'Terjadi kesalahan saat memperbarui profil pengguna.'
        );
    }
} else {
    $response = array(
        'status' => 'error',
        'message' => 'Tidak dapat mengubah profil admin.'
    );
}

// Mengirimkan respon sebagai JSON
header('Content-Type: application/json');
echo json_encode($response);

// Menutup koneksi ke database
mysqli_close($conn);

?>
