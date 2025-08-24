<?php
header('Content-Type: application/json');
error_reporting(E_ALL & ~E_NOTICE & ~E_WARNING);

// Veritabanı bilgileri
$host = "localhost";
$db = "heart_health_mobil";
$user = "root";
$pass = "";

// MySQL bağlantısı
$conn = new mysqli($host, $user, $pass, $db);
$conn->set_charset("utf8"); // Karakter seti uyumluluğu için

if ($conn->connect_error) {
    die(json_encode([
        "status" => "error",
        "message" => "Connection failed: " . $conn->connect_error
    ]));
}

// POST ile gelen değerleri alıyoruz ve trim/lowercase yapıyoruz
$email = strtolower(trim($_POST['email'] ?? ''));
$password = $_POST['password'] ?? '';

if (!$email || !$password) {
    echo json_encode([
        "status" => "error",
        "message" => "Email and password are required"
    ]);
    exit;
}

// Kullanıcı sorgusu: id ve password alıyoruz
$stmt = $conn->prepare("SELECT id, password FROM users WHERE LOWER(email) = ?");
if (!$stmt) {
    echo json_encode([
        "status" => "error",
        "message" => "Prepare failed: " . $conn->error
    ]);
    exit;
}

$stmt->bind_param("s", $email);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    $stmt->bind_result($id, $hashedPassword);
    $stmt->fetch();

    if (password_verify($password, $hashedPassword)) {
        // Login başarılı, userId döndür
        echo json_encode([
            "status" => "success",
            "message" => "Login successful",
            "userId" => $id
        ]);
    } else {
        echo json_encode([
            "status" => "error",
            "message" => "Invalid password"
        ]);
    }
} else {
    echo json_encode([
        "status" => "error",
        "message" => "User not found"
    ]);
}

$stmt->close();
$conn->close();
?>
