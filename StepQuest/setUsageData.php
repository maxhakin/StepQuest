<?php
// Create connection to database
$con = mysqli_connect("localhost", "unn_w22064166", "Mnimhiasb1", "unn_w22064166");

// Check connection
if (mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

// Data sent from the client with a POST request
$userID = $con->real_escape_string($_POST['userID']);
$date = $con->real_escape_string($_POST['date']); // Expecting a format like 'YYYY-MM-DD'
$steps = $con->real_escape_string($_POST['steps']);
$level = $con->real_escape_string($_POST['level']);

$stmt = $con->prepare("INSERT INTO appUsage (userID, date, steps, level) VALUES (?, ?, ?, ?, ?)");
$stmt->bind_param("sssis", $userID, $date, $steps, $level);

// Execute the query and check if it was successful
if ($stmt->execute()) {
    echo "New record created successfully";
} else {
    echo "Error: " . $stmt->error;
}

$stmt->close();
mysqli_close($con);
?>
