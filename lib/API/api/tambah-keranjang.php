<?php
header("Content-Type: application/json");
require 'conn.php';

// Menerima data dari request POST
$u_id = $_GET['u_id'];
$p_id = $_GET['p_id'];

// Query untuk menyimpan data ke tabel keranjang
$sql = "INSERT INTO `keranjang` (`id`, `u_id`, `p_id`, `qty`, `status`) VALUES (NULL, '".$u_id."', '".$p_id."', '1', 'keranjang');";

if (mysqli_query($conn, $sql)) {
    // Jika penyimpanan berhasil
    $response = array("status" => "success", "message" => "Data berhasil disimpan");
    echo json_encode($response);
} else {
    // Jika terjadi kesalahan dalam penyimpanan
    $response = array("status" => "error", "message" => "Terjadi kesalahan: " . mysqli_error($conn));
    echo json_encode($response);
}

// Menutup koneksi ke database
mysqli_close($conn);

?>
