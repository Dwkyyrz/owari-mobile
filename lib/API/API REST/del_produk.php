<?php

// Koneksi ke database
$host = "localhost";
$username = "root";
$password = "";
$database = "owari";

$conn = mysqli_connect($host, $username, $password, $database);
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Endpoint untuk menghapus produk berdasarkan ID
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Menerima data dari permintaan
    $product_id = $_POST['p_id'];

    // Query untuk menghapus produk berdasarkan ID
    $sql = "DELETE FROM produk WHERE p_id = '$product_id'";

    if (mysqli_query($conn, $sql)) {
        $response = array('status' => 'success', 'message' => 'Produk berhasil dihapus');
    } else {
        $response = array('status' => 'error', 'message' => 'Gagal menghapus produk: ' . mysqli_error($conn));
    }

    // Mengembalikan response dalam format JSON
    header('Content-Type: application/json');
    echo json_encode($response);
}

// Menutup koneksi database
mysqli_close($conn);
?>
