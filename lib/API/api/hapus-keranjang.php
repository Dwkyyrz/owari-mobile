<?php
header("Content-Type: application/json");
require 'conn.php';

// Menerima data dari request POST
$id = $_GET["id"];

// Query untuk menyimpan data ke tabel keranjang
$sql = "DELETE FROM `keranjang` WHERE `u_id` = ".$id.";";

if (mysqli_query($conn, $sql)) {
    // Jika penyimpanan berhasil
    $response = array("status" => "success", "message" => "Data berhasil Dihapus!");
    echo json_encode($response);
} else {
    // Jika terjadi kesalahan dalam penyimpanan
    $response = array("status" => "error", "message" => "Terjadi kesalahan: " . mysqli_error($conn));
    echo json_encode($response);
}

// Menutup koneksi ke database
mysqli_close($conn);

?>
