<?php
require_once("../php/Rating.php");

	
	$emailInputFromUser = $_POST['username'];
	//$emailInputFromUser = 'lam@lam.com';
	//$emailInputFromUser = '1';
	$arr = array("rating" => Rating::getPositivePercent($emailInputFromUser));
	
	echo json_encode($arr);
?>
