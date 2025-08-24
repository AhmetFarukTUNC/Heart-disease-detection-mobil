<?php
error_reporting(E_ALL & ~E_NOTICE & ~E_WARNING);
header('Content-Type: application/json');

$host = "localhost";
$db = "heart_health_mobil";
$user = "root";
$pass = ""; // Mysql şifren varsa buraya

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed"]));
}

$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

// Basit doğrulama
if (!$email || !$password) {
    echo json_encode(["status" => "error", "message" => "Email and password required"]);
    exit;
}

// Şifreyi hashle
$hashedPassword = password_hash($password, PASSWORD_DEFAULT);

// Kullanıcıyı ekle
$stmt = $conn->prepare("INSERT INTO users (email, password) VALUES (?, ?)");
$stmt->bind_param("ss", $email, $hashedPassword);

if ($stmt->execute()) {
    echo json_encode(["status" => "success", "message" => "Registered successfully"]);
} else {
    echo json_encode(["status" => "error", "message" => "Email already exists"]);
}

$stmt->close();
$conn->close();
?>
