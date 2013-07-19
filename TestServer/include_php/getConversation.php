<?php
require_once("../php/Message.php");

/*
$owner_email = "lam";
$receiver_email = "xyz";

*/
$owner_email = $_POST['ownerEmail'];
$receiver_email = $_POST['receiverEmail'];

$result = Message::getConversation($owner_email, $receiver_email);
echo json_encode($result);
?>