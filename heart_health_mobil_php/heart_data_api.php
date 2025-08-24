<?php
header('Content-Type: application/json');

// MySQL bağlantısı
$servername = "127.0.0.1";
$username = "root";
$password = "";
$dbname = "heart_health_mobil";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
}

// Flutter'dan gelen userId
$userId = isset($_GET['userId']) ? intval($_GET['userId']) : 0;

// userId filtreleme
$sql = "SELECT * FROM heart_data WHERE userId = $userId";
$result = $conn->query($sql);

$data = [];
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

echo json_encode($data);
$conn->close();
?>
