<?php
// Database configuration
$conn = mysqli_connect("localhost","unn_w22064166","Mnimhiasb1","unn_w22064166");

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Assume POST data is JSON encoded, including userID and an array of dailySteps
$content = file_get_contents("php://input");
$decodedData = json_decode($content, true);

$userID = $decodedData['userID'];
$dailySteps = $decodedData['dailySteps'];

// Prepare SQL statement to insert or update daily steps
$query = "INSERT INTO dailyStats (userID, date, steps) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE steps = VALUES(steps)";

$stmt = $conn->prepare($query);

if (!$stmt) {
    echo json_encode(["success" => false, "message" => "Failed to prepare statement: " . $conn->error]);
    exit;
}

foreach ($dailySteps as $step) {
    $date = $step['date'];
    $steps = $step['steps'];

    $stmt->bind_param("isi", $userID, $date, $steps);
    if (!$stmt->execute()) {
        echo json_encode(["success" => false, "message" => "Error executing statement: " . $stmt->error]);
        exit;
    }
}

echo json_encode(["success" => true, "message" => "Data inserted/updated successfully."]);

$stmt->close();
$conn->close();
?>
