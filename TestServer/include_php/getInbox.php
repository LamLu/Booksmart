<?php
require_once("../php/Message.php");

$email = $_POST['email'];


$result = Message::getInbox($email);
echo json_encode($result);
?>