<?php
// Create connection to database
$con = mysqli_connect("localhost","unn_w22064166","Mnimhiasb1","unn_w22064166");

// Check connection
if (mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

// userID sent from the client with a POST request
$userID = $con->real_escape_string($_POST['userID']);

$stmt = $con->prepare("SELECT * FROM userData WHERE userID = ?");
$stmt->bind_param("s", $userID);
$stmt->execute();
$result = $stmt->get_result();
$json_array = array();

// Prepares all the results to be encoded in JSON
while ($row = $result->fetch_assoc()) {
    array_push($json_array, $row);
}

// Encodes array with results from database
echo json_encode($json_array);

$stmt->close();
mysqli_close($con);
?>
