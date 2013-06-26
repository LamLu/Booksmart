<?php

require_once("../php/Message.php");

/**
 * Tests the functionality of insertMessage
 * @author Dhruv Mevada
 */

echo "Insert Message test";

$sender_email = 'cowboy';
$receiver_email = 'xyz';
$message = "This is the first test for insert message";

$result_array = Message::insertMessage($sender_email, $receiver_email, $message);

echo json_encode($result_array);

?>