<?php
header('Content-Type: application/json');

$con = mysqli_connect("localhost","unn_w22064166","Mnimhiasb1","unn_w22064166");

if (mysqli_connect_errno()) {
    echo json_encode(["success" => false, "message" => "Failed to connect to MySQL: " . mysqli_connect_error()]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Assuming you've checked and sanitized your POST data
    $userName = $con->real_escape_string($_POST['userName']);
    $highLevel = $con->real_escape_string($_POST['highLevel']);
    $totalSteps = $con->real_escape_string($_POST['totalSteps']);

    $stmt = $con->prepare("INSERT INTO userData (userName, highLevel, totalSteps) VALUES (?, ?, ?)");
    if (!$stmt) {
        echo json_encode(["success" => false, "message" => "Failed to prepare statement: " . $con->error]);
        exit;
    }

    $stmt->bind_param("sii", $userName, $highLevel, $totalSteps);
    if ($stmt->execute()) {
        $last_id = $con->insert_id;
        echo json_encode(["success" => true, "message" => "Record inserted successfully", "userID" => $last_id]);
    } else {
        echo json_encode(["success" => false, "message" => "Error executing statement: " . $stmt->error]);
    }

    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "This is not a POST request."]);
}

mysqli_close($con);
?>
