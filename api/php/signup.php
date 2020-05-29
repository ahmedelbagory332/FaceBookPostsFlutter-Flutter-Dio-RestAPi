<?php  


include "DatabaseConfig.php";



if($_SERVER['REQUEST_METHOD'] == 'POST')
{
   
   
    $name = $_POST["name"]; 
    $email = $_POST["email"]; 
    $pass = $_POST["pass"];
    
    $sql = "SELECT * FROM user_flutter where email = '$email'";
    $result = mysqli_query($conn, $sql);
    if(mysqli_num_rows($result)>0)
        {
            $status = "exists";
        }

      else
      {
         $InsertSQL = "insert into user_flutter (name,email,pass) values ('$name','$email','$pass')";
       
       if(mysqli_query($conn, $InsertSQL)){
        
              $status = "ok";

        
       }
       else{
        
              $status = "error";

        
        
       }
    
      }
   
}  
echo json_encode(array("response"=>$status));

  
?>  