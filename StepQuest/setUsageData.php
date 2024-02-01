<?php
// Create connection to database
$conn = mysqli_connect("localhost", "unn_w22064166", "Mnimhiasb1", "unn_w22064166");

// Check connection
if (mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

// Data sent from the client with a POST request
$userID = $conn->real_escape_string($_POST['userID']);
$steps = $conn->real_escape_string($_POST['steps']);
$level = $conn->real_escape_string($_POST['level']);

// Prepare the INSERT statement with NOW() for the current datetime
$stmt = $conn->prepare("INSERT INTO usageData (userID, accessTime, totalSteps, highLevel) VALUES (?, NOW(), ?, ?)");
$stmt->bind_param("iii", $userID, $steps, $level);

// Execute the query and check if it was successful
if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Usage Data inserted successfully."]);
} else {
    echo json_encode(["success" => false, "message" => "Error executing statement: " . $stmt->error]);
}

$stmt->close();
mysqli_close($conn);
?>
