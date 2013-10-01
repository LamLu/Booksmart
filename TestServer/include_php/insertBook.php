<?php
/**
 * function to insert book into databae
 * @author Lam Lu
 */
include_once '../php/BookProcessor.php';


$email = $_POST['email'];
$title = $_POST['title'];
$edition = $_POST['edition'];
$isbn10 = $_POST['isbn10'];
$isbn13 = $_POST['isbn13'];
$authors = $_POST['authors'];
$publisher = $_POST['publisher'];
$subject = $_POST['subject'];

$authorArr = explode (",", $authors);
$firstImageFile = $_FILES['uploadedImg0'];
$secondImageFile = $_FILES['uploadedImg1'];



$result = BookProcessor::insertBook($email, $title, $edition, $isbn10, $isbn13, $publisher,$authorArr, $subject, $firstImageFile,
		$secondImageFile);
echo json_encode($result);
?>