<?php

// Create connection
$con = mysqli_connect("localhost","unn_w22064166","Mnimhiasb1","unn_w22064166");

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL to fetch data
$sql = "SELECT userName, highLevel, totalSteps FROM userData ORDER BY highLevel DESC, totalSteps DESC";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $userData = [];

    // Fetch associative array
    while($row = $result->fetch_assoc()) {
        $userData[] = $row;
    }

    // Output data as JSON
    echo json_encode($userData);
} else {
    echo json_encode(["message" => "No data found"]);
}

// Close connection
$conn->close();
?>
