<?php
/*
* To test the get_inbox method
* 
* Created by Shivalik Narad
*/


require_once ("../php/Message.php");
$user_email = "test1@test1.com";
$resultArray = Message::getInbox($user_email);
echo (json_encode ($resultArray['result']));



?>