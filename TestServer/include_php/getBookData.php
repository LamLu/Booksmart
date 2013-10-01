<?php

require_once ("../php/BookProcessor.php");

$email = $_POST['email'];

$obj = BookProcessor::getBookFromUser($email);
echo (json_encode($obj));
/*
echo (json_encode ($obj['result']));
echo '<br />';
*/
/*

$obj =  BookProcessor::getBookFromAuthor("Tyler", null);
echo (json_encode($obj['result']));
echo '<br />';


$obj =  BookProcessor::getBookFromSubject("BS");
echo (json_encode($obj['result']));
echo '<br />';
*/
?>