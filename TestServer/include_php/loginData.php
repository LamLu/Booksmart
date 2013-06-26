<?php
/*
* this is to include the php files outside the wwwroot folder for 
* security reason
*/

require_once('../php/Authentication.php');

$emailInputFromUser =  $_POST['username'];
$passwordInputFromUser = $_POST['password'];


$p = array("login" => "passed");
$f = '{"login":"failed"}';
header("Content-Type: text/json");


if ((!isset($emailInputFromUser) || !isset($passwordInputFromUser)) || 
		(empty($emailInputFromUser) || empty($passwordInputFromUser))) //if email and password is not set yet or empty
    echo ($f);

else
{
	$authentication = new Authentication($emailInputFromUser, $passwordInputFromUser);
	if($authentication->login())
	{
		$p["userProfile"] = $authentication->retrieveUserProfile();
		echo(json_encode($p));
	}
	else
		echo($f);
}

?>