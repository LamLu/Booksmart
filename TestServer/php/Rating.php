<?php
require_once("DBConnection.php");
class Rating
{
	public static function getUserId($userEmail)
	{
		
		$query = "Select id from user_profile where email = ?";
		$params = array('s',$userEmail);
		$resultArray = DBConnection::processSQLStatement($query, $params, TRUE);
		//echo json_encode($resultArray['result']['0']['id']);
		return $resultArray['result']['0']['id'];
	}
	public static function insertRating($rating)
	{
		$userId = Rating::getUserId($rating['userEmail']);
		
		
		$raterId = Rating::getUserId($rating['raterEmail']);
		//echo $raterId;
		$query = "insert into rating (owner_id,rater_id,rating,rater_comment) values (?,?,?,?)";
		$params = array('iiis', $userId, $raterId, $rating['rating'], $rating['rater_comment']);
		$resultArray = DBConnection::processSQLStatement($query, $params, FALSE);
	}
	public static function getRating($userEmail)
	{
		$userId = Rating::getUserId($userEmail);
		$query = "Select * from rating where owner_id = ?";
		$params = array('i',$userId);
		$resultArray = DBConnection::processSQLStatement($query, $params, TRUE);
		echo json_encode($resultArray['result']);
	}
	public static function getSumOfPostiveRating($userEmail)
	{
		$userId = Rating::getUserId($userEmail);
		$query = "Select count(rating) from rating where owner_id = ? and rating > 0";
		$params = array('i',$userId);
		$resultArray = DBConnection::processSQLStatement($query, $params, TRUE);
		//echo json_encode($resultArray['result']['0']['count(rating)']);
		return $resultArray['result']['0']['count(rating)'];
	}
	public static function getSumOfNegativeRating($userEmail)
	{
		$userId = Rating::getUserId($userEmail);
		$query = "Select count(rating) from rating where owner_id = ? and rating < 0";
		$params = array('i',$userId);
		$resultArray = DBConnection::processSQLStatement($query, $params, TRUE);
		//echo json_encode($resultArray['result']['0']['count(rating)']);
		return $resultArray['result']['0']['count(rating)'];
	}	
	public static function getSumOfAllRating($userEmail)
	{
		$userId = Rating::getUserId($userEmail);
		$query = "Select count(owner_id) from rating where owner_id = ?";
		$params = array('i',$userId);
		$resultArray = DBConnection::processSQLStatement($query, $params, TRUE);
		//echo json_encode($resultArray['result']);
		return $resultArray['result']['0']['count(owner_id)'];
	}
	public static function getPositivePercent($userEmail)
	{
		$positiveRating = Rating::getSumOfPostiveRating($userEmail);
		$totalRating = Rating::getSumOfAllRating($userEmail);
		$percentage = $positiveRating / $totalRating * 100;
		echo number_format($percentage);
		return number_format($percentage);
	}
}
	$rating = array (
			'userEmail'   => 'sample@sample.com',
			'raterEmail'   => 'sample2@sample.com',
			'rating'   => '-1',
			'rater_comment'   => 'good',
			);
	//Rating::insertRating($rating);
	Rating::getRating('sample@sample.com');
	//Rating::getSumOfPostiveRating('sample@sample.com');
	//Rating::getSumOfNegativeRating('sample@sample.com');
	//Rating::getSumOfAllRating('sample@sample.com');
	Rating::getPositivePercent('sample@sample.com');
?>