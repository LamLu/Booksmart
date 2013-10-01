<?php
require_once("../php/Message.php");
/*
$message = "Test";
$owner_email = "lam";
$receiver_email = "xyz;
*/
$message = $_POST['message'];
$owner_email = $_POST['ownerEmail'];
$receiver_email = $_POST['receiverEmail'];

$result = Message::insertMessage($message,$owner_email, $receiver_email);
echo json_encode($result);
?>