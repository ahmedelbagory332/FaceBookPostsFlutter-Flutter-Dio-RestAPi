<?php

include "DatabaseConfig.php";
    
    $posts = array();
    $sql = "SELECT * FROM facebook";
    
    
    $result = $conn->query($sql);
    
    
    if ($result->num_rows > 0) {
    // output data of each row
	while($row = $result->fetch_assoc()) {
	
	    $id = $row["id"];
	    $name = $row["name"];
	    $post = $row["post"]; 
	    $time = $row["time"]; 
	    $img = $row["image"];
	    
	    $items = array("id"=>$id,"name"=>$name ,"post"=>$post ,"time"=>$time ,"image"=>$img);
	
	
	    array_push($posts, $items);
	
        }
    
	    // show data in json format
	    echo json_encode($posts);
	    
    
  }
    else
    {
	$status = "faild";
	echo json_encode(array("response"=>$status));
    }
 
?>