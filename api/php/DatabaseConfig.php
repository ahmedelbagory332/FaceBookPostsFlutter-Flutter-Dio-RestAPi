<?php

//Define your host here.
$HostName = "localhost";

//Define your database username here.
$HostUser = "root";

//Define your database password here.
$HostPass = "";

//Define your database name here.
$DatabaseName = "Facebook";

$conn = new mysqli($HostName, $HostUser, $HostPass, $DatabaseName);

if($conn)
{
   // echo "connected";
}
else
{
      // echo "Not connected";
 
}

?>