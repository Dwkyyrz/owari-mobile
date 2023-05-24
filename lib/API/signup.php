<?php

// Menerima permintaan POST dari aplikasi Flutter
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Mengambil data yang dikirimkan melalui permintaan POST
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Menggunakan koneksi ke database (sesuaikan dengan konfigurasi Anda)
    $servername = "localhost";
    $dbUsername = "root";
    $dbPassword = "";
    $dbName = "owari";

    // Membuat koneksi ke database
    $conn = new mysqli($servername, $dbUsername, $dbPassword, $dbName);

    // Memeriksa koneksi ke database
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Mengeksekusi query untuk mencari pengguna dengan username dan password yang cocok
    $query = "SELECT * FROM user WHERE email = '$email' AND password = '$password'";
    $result = $conn->query($query);

    // Memeriksa apakah query berhasil dieksekusi
    if ($result) {
        // Memeriksa apakah ada pengguna yang cocok ditemukan
        if ($result->num_rows > 0) {
            // Pengguna ditemukan, mengirimkan status sukses ke aplikasi Flutter
            $response['status'] = 'success';
            $response['message'] = 'Login successful';
        } else {
            // Pengguna tidak ditemukan, mengirimkan status gagal ke aplikasi Flutter
            $response['status'] = 'error';
            $response['message'] = 'Invalid email or password';
        }
    } else {
        // Query gagal dieksekusi, mengirimkan status gagal ke aplikasi Flutter
        $response['status'] = 'error';
        $response['message'] = 'Query execution failed';
    }

    // Mengirimkan response ke aplikasi Flutter dalam format JSON
    echo json_encode($response);

    // Menutup koneksi ke database
    $conn->close();
}
?>
