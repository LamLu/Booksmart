<?php
require_once("../php/Rating.php");


	$userEmail = $_POST['ownerEmail'];
	$raterEmail = $_POST['raterEmail'];
	$comment = $_POST['comment'];
	$rating = $_POST['rating'];

	$ratingArr = array (
			'userEmail'   => $userEmail,
			'raterEmail'   => $raterEmail,
			'rating'   => $rating,
			'rater_comment'   => $comment,
	);
	/*
	$rating = array (
			'userEmail'   => 'sample@sample.com',
			'raterEmail'   => 'sample2@sample.com',
			'rating'   => '-1',
			'rater_comment'   => 'good',
			);
	*/
	Rating::insertRating($ratingArr);
	
?>