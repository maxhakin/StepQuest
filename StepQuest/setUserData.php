<?php
// Create connection to database
$con = mysqli_connect("localhost", "unn_w22064166", "Mnimhiasb1", "unn_w22064166");

// Check connection
if (mysqli_connect_errno()) {
    echo json_encode(["success" => false, "message" => "Failed to connect to MySQL: " . mysqli_connect_error()]);
    exit;
}

// Data sent from the client with a POST request
$userName = $con->real_escape_string($_POST['userName']);
$highLevel = $con->real_escape_string($_POST['highLevel']);
$totalSteps = $con->real_escape_string($_POST['totalSteps']);

$stmt = $con->prepare("INSERT INTO userData (userName, highLevel, totalSteps) VALUES (?, ?, ?)");
$stmt->bind_param("sii", $userName, $highLevel, $totalSteps);

// Execute the query
if ($stmt->execute()) {
    // Fetch the last inserted ID
    $last_id = $con->insert_id;
    echo json_encode(["success" => true, "message" => "Record inserted successfully", "userID" => $last_id]);
} else {
    echo json_encode(["success" => false, "message" => "Error: " . $stmt->error]);
}

$stmt->close();
mysqli_close($con);
?>

