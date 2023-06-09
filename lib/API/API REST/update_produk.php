
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

// Endpoint untuk mengupdate produk berdasarkan ID
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Menerima data dari permintaan
    $product_id = $_POST['p_id'];
    $cat_id = $_POST['cat_id'];
    $nama = $_POST['nama'];
    $deskripsi = $_POST['deskripsi'];
    $stock = $_POST['stock'];
    $harga = $_POST['harga'];
    $ukuran = $_POST['ukuran'];
    $foto = $_POST['foto'];

    // Query untuk mengupdate produk berdasarkan ID
    $sql = "UPDATE produk SET cat_id='$cat_id', nama='$nama', deskripsi='$deskripsi', stock='$stock', harga='$harga', ukuran='$ukuran', foto='$foto' WHERE p_id='$product_id'";

    if (mysqli_query($conn, $sql)) {
        $response = array('status' => 'success', 'message' => 'Produk berhasil diupdate');
    } else {
        $response = array('status' => 'error', 'message' => 'Gagal mengupdate produk: ' . mysqli_error($conn));
    }

    // Mengembalikan response dalam format JSON
    header('Content-Type: application/json');
    echo json_encode($response);
}

// Menutup koneksi database
mysqli_close($conn);
?>
