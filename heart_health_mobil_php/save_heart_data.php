<?php
$host = "localhost";
$db   = "heart_health_mobil";
$user = "root";
$pass = "";
$charset = "utf8mb4";

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);

    // Name kolonu eklendi
    $stmt = $pdo->prepare("INSERT INTO heart_data 
        (userId, Name, Age, Sex, ChestPainType, RestingBP, Cholesterol, FastingBS, RestingECG, MaxHR, ExerciseAngina, Oldpeak, ST_Slope, Prediction)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

    $stmt->execute([
        $_POST['userId'],     // Flutter'dan gelen userId
        $_POST['Name'],       // Flutter'dan gelen Name
        $_POST['Age'],
        $_POST['Sex'],
        $_POST['ChestPainType'],
        $_POST['RestingBP'],
        $_POST['Cholesterol'],
        $_POST['FastingBS'],
        $_POST['RestingECG'],
        $_POST['MaxHR'],
        $_POST['ExerciseAngina'],
        $_POST['Oldpeak'],
        $_POST['ST_Slope'],
        $_POST['Prediction']
    ]);

    echo json_encode(["status" => "success"]);
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
