<?php 
 //database constants
  define('DB_HOST', 'localhost');
  define('DB_USER', 'root');
  define('DB_PASS', '');
  define('DB_NAME', 'owari');
  
  //connecting to database and getting the connection object
  $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
  
  //Checking if any error occured while connecting
  if (mysqli_connect_errno()) {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  die();
  }
  //creating a query
  $stmt = $conn->prepare("SELECT * FROM produk;");
  
  //executing the query 
  $stmt->execute();
  
  //binding results to the query 
  $stmt->bind_result($p_id, $cat_id, $nama, $deskripsi, $stock, $harga, $ukuran, $foto);
  $produk = array(); 
  
  //traversing through all the result 
  while($stmt->fetch()){
  $temp = array();
  $temp['p_id'] = $p_id;
  $temp['cat_id'] = $cat_id; 
  $temp['nama'] = $nama; 
  $temp['deskripsi'] = $deskripsi;
  $temp['stock'] = $stock; 
  $temp['harga'] = $harga; 
  $temp['ukuran'] = $ukuran; 
  $temp['foto'] = $foto;
  array_push($produk, $temp);
  }

  //displaying the result in json format 
  echo json_encode($produk, JSON_UNESCAPED_UNICODE);