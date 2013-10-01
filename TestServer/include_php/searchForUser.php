<?php
require_once("../php/DBConnection.php");

$searchInput = $_POST['username'];


$query = "select CONCAT (first_name, ' ', last_name) AS full_name, email, profile_img_src from user_profile where CONCAT (first_name, ' ', last_name) like CONCAT('%', ? ,'%') or CONCAT (last_name , ' ', first_name) like CONCAT('%', ? ,'%') or email like CONCAT('%', ? ,'%')";

$params = array('sss',$searchInput,$searchInput,$searchInput);

$result = DBConnection::processSQLStatement($query, $params, TRUE);
$result['result'];
echo json_encode($result);
	
?>