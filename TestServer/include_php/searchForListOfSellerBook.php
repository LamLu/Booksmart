<?php
require_once("../php/DBConnection.php");

$searchInput = $_POST['book'];
//$searchInput = 'fire';
//$query = "select title, edition, isbn_10, isbn_13 from book where title like CONCAT('%', ? ,'%') or isbn_10  like CONCAT('%', ? ,'%') or isbn_13  like CONCAT('%', ? ,'%')";


$params = array('sss',$searchInput,$searchInput,$searchInput);

$result = DBConnection::processSQLStatement($query, $params, TRUE);

echo json_encode($result);
	
?>