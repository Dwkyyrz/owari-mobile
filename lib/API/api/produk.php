<?php

header("Content-Type: application/json");
    require 'conn.php';
// Membaca data produk dari tabel
$sql = "SELECT * FROM produk";
$result = $conn->query($sql);

$products = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $product = array(
            "p_id" => $row["p_id"],
            "category" => $row["category"],
            "nama" => $row["nama"],
            "deskripsi" => $row["deskripsi"],
            "stock" => $row["stock"],
            "harga" => $row["harga"],
            "ukuran" => $row["ukuran"],
            "foto" => $row["foto"],
            "created_at" => $row["created_at"],
            "updated_at" => $row["updated_at"]
        );
        array_push($products, $product);
    }
}

// Mengirimkan response JSON
echo json_encode($products);

$conn->close();

?>
