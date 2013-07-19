<?php
require_once('../php/BookProcessor.php');

$imageFile = $_FILES['uploadedImg'];
$id = 2;
$retrievedAttr = "img_path_1";

echo (json_encode(BookProcessor::uploadImage($imageFile,$id,$retrievedAttr)));

?>