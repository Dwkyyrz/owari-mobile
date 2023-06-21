<?php
// Connection details
$servername = "localhost";
$username = "id20870607_db_owari";
$password = "Owari_1000";
$database = "id20870607_db_owari";

// Connect to the database
$connection = mysqli_connect($servername, $username, $password, $database);

// Check connection
if (!$connection) {
    die("Connection failed: " . mysqli_connect_error());
}

// Endpoint for user login
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['email']) && isset($_POST['password'])) {
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Retrieve user data from the database
    $query = "SELECT * FROM user WHERE email = '$email' AND password = '$password' AND tipe = 'admin'";
    $result = mysqli_query($connection, $query);

    if (mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);

        // Construct response JSON
        $response = [
            'status' => 'success',
            'user' => [
                'id' => $row['u_id'],
                'nama' => $row['username'],
                'email' => $row['email'],
                'password' => $row['password'],
                'telp' => $row['telp'],
                'alamat' => $row['alamat']
            ],
        ];
    } else {
        // User not found
        $response = [
            'status' => 'error',
            'message' => 'Invalid email or password'
        ];
    }

    // Return response as JSON
    header('Content-Type: application/json');
    echo json_encode($response);
}

// Close the database connection
mysqli_close($connection);
?>
