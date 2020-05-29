<?php
include "DatabaseConfig.php";

if($_SERVER['REQUEST_METHOD'] == 'POST')
{
  
    $email = $_POST["email"]; 
    $pass = $_POST["pass"];

$sql = "SELECT * FROM user_flutter where email = '$email' and pass = '$pass'";
$result = mysqli_query($conn, $sql);

if(!mysqli_num_rows($result)>0)
{
    $status = "faild";
    echo json_encode(array("response"=>$status));

}
else
{
    $status = "ok";
    echo json_encode(array("response"=>$status));


}
mysqli_close($conn);
}

?>