<?php
// Create connection to database
$con=mysqli_connect("localhost","unn_w22064166","Mnimhiasb1","unn_w22064166");
 
// Check connection
if (mysqli_connect_errno())
{
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

// Bind userID, highLevel, and totalSteps received via POST request
$userID = $con->real_escape_string($_POST['userID']);
$highLevel = $con->real_escape_string($_POST['highLevel']);
$totalSteps = $con->real_escape_string($_POST['totalSteps']);

// Prepare the UPDATE statement
$stmt = $con->prepare("UPDATE userData SET highLevel = ?, totalSteps = ? WHERE userID = ?");
$stmt->bind_param("iii", $highLevel, $totalSteps, $userID);

// Execute the query and check if it was successful
if ($stmt->execute()) {
    $response = array("success" => true, "message" => "Record updated successfully");
} else {
    $response = array("success" => false, "message" => "Error updating record");
}

// Encode and return the response as JSON
echo json_encode($response);

$stmt->close();
mysqli_close($con);
?>

