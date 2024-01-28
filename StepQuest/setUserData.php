<?php
// Create connection to database
$con=mysqli_connect("localhost","unn_w22064166","Mnimhiasb1","unn_w22064166");
 
// Check connection
if (mysqli_connect_errno())
{
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

// Data sent from the client with a POST request
$userName = $con->real_escape_string($_POST['userName']);
$highLevel = $con->real_escape_string($_POST['highLevel']);
$totalSteps = $con->real_escape_string($_POST['totalSteps']);

$stmt = $con->prepare("INSERT INTO userData (email, userName, highLevel, totalSteps) VALUES (?, ?, ?, ?)");
$stmt->bind_param("ssii", $userName, $highLevel, $totalSteps);

// Execute the query and check if it was successful
if ($stmt->execute()) {
    $response = array("success" => true, "message" => "Record inserted successfully");
} else {
    $response = array("success" => false, "message" => "Error inserting record");
}

// Encode and return the response as JSON
echo json_encode($response);

$stmt->close();
mysqli_close($con);
?>

