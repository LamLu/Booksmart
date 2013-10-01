<?php
require_once("../php/Rating.php");
	//$emailInputFromUser = $_POST['username'];
	echo Rating::getRating('sample@sample.com');
	//echo Rating::getRating($emailInputFromUser);
?>