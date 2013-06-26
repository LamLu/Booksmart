<?php

require_once ("../php/BookProcessor.php");

$obj = BookProcessor::getBookFromUser("sample@sample.com");
echo (json_encode ($obj['result']));
echo '<br />';



$obj =  BookProcessor::getBookFromAuthor("Tyler", null);
echo (json_encode($obj['result']));
echo '<br />';


$obj =  BookProcessor::getBookFromSubject("BS");
echo (json_encode($obj['result']));
echo '<br />';
?>