<?php

require_once ("../php/Message.php");

$obj = Message::getConversation("sample@sample.com", "sample2@sample.com");
echo (json_encode ($obj['result']));
echo '<br />';

?>