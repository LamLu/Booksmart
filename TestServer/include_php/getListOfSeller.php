<?php
require_once("../php/DBConnection.php");

$searchInput = $_POST['title'];
//$searchInput = "Kite Runner";
$query = "select CONCAT (a.first_name, ' ', a.last_name) AS full_name, a.email, a.profile_img_src from user_profile a, book b, user_book ab where a.id = ab.user_id and b.id = ab.book_id and b.title = ?";

 


$params = array('s',$searchInput);

$result = DBConnection::processSQLStatement($query, $params, TRUE);

echo json_encode($result);

?>