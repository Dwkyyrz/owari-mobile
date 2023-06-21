<?php
require 'conn.php';
// Database constants

// Endpoint untuk menambahkan produk baru
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Menerima data dari form
    $cat_id = $_POST['cat_id'];
    $nama = $_POST['nama'];
    $deskripsi = $_POST['deskripsi'];
    $stock = $_POST['stock'];
    $harga = $_POST['harga'];
    $ukuran = $_POST['ukuran'];
    $foto = $_POST['foto'];

    // Query untuk menambahkan produk ke dalam tabel
    $sql = "INSERT INTO produk (cat_id, nama, deskripsi, stock, harga, ukuran, foto) 
            VALUES ('$cat_id', '$nama', '$deskripsi', $stock, $harga, '$ukuran', '$foto')";

    if (mysqli_query($conn, $sql)) {
        $response = array('status' => 'success', 'message' => 'Produk berhasil ditambahkan');
    } else {
        $response = array('status' => 'error', 'message' => 'Gagal menambahkan produk: ' . mysqli_error($conn));
    }

    // Mengembalikan response dalam format JSON
    header('Content-Type: application/json');
    echo json_encode($response);
}

// Menutup koneksi database
mysqli_close($conn);
?>