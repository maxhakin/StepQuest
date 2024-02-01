<?php
// Create connection to database
$con = mysqli_connect("localhost", "unn_w22064166", "Mnimhiasb1", "unn_w22064166");

// Check connection
if (mysqli_connect_errno()) {
    echo json_encode(["success" => false, "message" => "Failed to connect to MySQL: " . mysqli_connect_error()]);
    exit;
}

// Debugging: Print all POST data
//var_dump($_POST);
//print_r($_POST);
//echo "<br>";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Process POST request
    echo 'This is a post request';
} else {
    echo 'This is not a POST request.';
}

echo "Request Method: " . $_SERVER['REQUEST_METHOD'];

// Check if POST data is set
if (!isset($_POST['userName']) || !isset($_POST['highLevel']) || !isset($_POST['totalSteps'])) {
    echo json_encode(["success" => false, "message" => "POST data not set correctly"]);
    exit;
}



// Data sent from the client with a POST request
$userName = $con->real_escape_string($_POST['userName']);
$highLevel = $con->real_escape_string($_POST['highLevel']);
$totalSteps = $con->real_escape_string($_POST['totalSteps']);

// Prepare the SQL statement
$stmt = $con->prepare("INSERT INTO userData (userName, highLevel, totalSteps) VALUES (?, ?, ?)");

// Check if the statement was prepared correctly
if (!$stmt) {
    echo json_encode(["success" => false, "message" => "Failed to prepare statement: " . $con->error]);
    exit;
}

// Bind parameters to the prepared statement
$stmt->bind_param("sii", $userName, $highLevel, $totalSteps);

// Execute the query
if ($stmt->execute()) {
    // Fetch the last inserted ID
    $last_id = $con->insert_id;
    echo json_encode(["success" => true, "message" => "Record inserted successfully", "userID" => $last_id]);
} else {
    echo json_encode(["success" => false, "message" => "Error executing statement: " . $stmt->error]);
}

// Close the statement and the connection
$stmt->close();
mysqli_close($con);
?>
