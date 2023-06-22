<?php
header("Content-Type: application/json");
require 'conn.php';

// Membaca data produk dari tabel
$id = $_GET["id"];

$sql = "SELECT user.username, user.alamat, produk.nama, produk.harga, produk.category, produk.ukuran
        FROM user
        JOIN keranjang ON user.u_id = keranjang.u_id
        JOIN produk ON keranjang.p_id = produk.p_id
        WHERE keranjang.u_id = ".$id.";";

$result = $conn->query($sql);

$products = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $product = array(
            "nama"      => $row["nama"],
            "harga"     => $row["harga"],
            "category"  => $row["category"],
            "ukuran"    => $row["ukuran"]
        );
        array_push($products, $product);
    }
}

// Mengirimkan response JSON
echo json_encode($products);

$conn->close();
?>
