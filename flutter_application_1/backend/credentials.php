<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$host = 'fdb1029.awardspace.net'; 
$dbname = '4564625_myfitnesspal'; 
$username = '4564625_myfitnesspal'; 
$password = 'T0*Y3JG+4x!w]GL3';

// Create a connection to the database
$conn = new mysqli($host, $username, $password, $dbname);

// Check the connection
if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Database connection failed"]);
    exit;
}

// Handle POST requests
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $inputData = json_decode(file_get_contents("php://input"), true);

    if ($inputData === null) {
        echo json_encode(["status" => "error", "message" => "Invalid JSON format"]);
        exit;
    }

    $username = $inputData['username'] ?? '';
    $password = $inputData['password'] ?? '';

    // Check if username and password are provided
    if (empty($username) || empty($password)) {
        echo json_encode(["status" => "error", "message" => "Username and password are required"]);
        exit;
    }

    // SQL query to retrieve the hashed password for the given username
    $sql = "SELECT password FROM user WHERE username = ?";
    $stmt = $conn->prepare($sql);

    if ($stmt === false) {
        echo json_encode(["status" => "error", "message" => "Error preparing query"]);
        exit;
    }

    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $hashedPassword = $row['password'];

        // Verify the password
        if (password_verify($password, $hashedPassword)) {
            echo json_encode(["status" => "success", "message" => "Login successful"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Invalid username or password"]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "Invalid username or password"]);
    }

    $stmt->close();
    $conn->close();
} else {
    http_response_code(405);
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}
?>