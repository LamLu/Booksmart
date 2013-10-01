<?php
/**
 * regiter php
 */
require_once('../User.php');

$emailSignUp =  $_POST['emailsignup'];
$passwordSignUp = $_POST['passwordsignup'];

   //create user
   $user = User::constructWithEmailPassword($emailSignUp, $passwordSignUp );
   
   if ((!isset($emailSignUp) || !isset($passwordSignUp)) || (empty($emailSignUp) ||empty($passwordSignUp ))) //if email and password is not set yet or empty
   {
   	echo ($f);
   	exit();
   }
   
   if($user->alreadyRegister() == true) 
   {
      echo '{"register": "failed", "error": "Username has been used"}';
	  //possible prompt for user to re-enter email and send it back to User class
	  //$user->setEmail("new email");
   } 
   else 
   {
	   //user can't register due to duplicate salt, try 10 time;
      if(!$user->register() && $count<5)
	  {
	  	$user->register();
		$count++;
	  }
	  else echo '{"register":"passed"}';
   }

?>