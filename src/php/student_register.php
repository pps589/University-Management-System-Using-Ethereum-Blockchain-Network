<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "test";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
$ch=curl_init();
curl_setopt($ch,CURLOPT_URL,"localhost:3000/");
curl_setopt($ch,CURLOPT_POST,1);
curl_setopt($ch,CURLOPT_POSTFIELDS,POST DATA);
$result=curl_exec($ch);
$name=$_POST['name'];
$email=$_POST['email']
$sql = "INSERT INTO test (name,email)
VALUES ('$name','$email')";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}
print_r($result);
curl_close($ch);
$conn->close();
?>