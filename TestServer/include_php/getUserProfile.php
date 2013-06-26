<?php
require_once("../php/DBConnection.php");

//$emailInputFromUser = $_POST['username'];
$emailInputFromUser = 'sample@sample.com';
$query = "Select email from user_profile where email != ?";
$params = array('s',$emailInputFromUser);
$result = DBConnection::processSQLStatement($query, $params, TRUE);
echo json_encode($result);	
?>