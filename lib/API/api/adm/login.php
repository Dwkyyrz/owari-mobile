<?php
// Connection details
    require 'conn.php';


// Endpoint for user login
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['email']) && isset($_POST['password'])) {
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Retrieve user data from the database
    $query = "SELECT * FROM users WHERE email = '$email' AND password = '$password'";
    $result = mysqli_query($conn, $query);

    if (mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);

        // Construct response JSON
        $response = [
            'status' => 'success',
            'user' => [
                'id' => $row['id'],
                'nama' => $row['username'],
                'email' => $row['email'],
                'password' => $row['password'],
                // 'telp' => $row['telp'],
                // 'alamat' => $row['alamat']
            ],
        ];
    } else {
        // User not found
        $response = [
            'status' => 'error',
            'message' => 'Invalid email or password',
        ];
    }

    // Return response as JSON
    header('Content-Type: application/json');
    echo json_encode($response);
}

// Close the database connection
mysqli_close($conn);
?>
