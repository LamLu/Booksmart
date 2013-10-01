<?php
require_once("../php/DBConnection.php");


$searchInput = $_POST['email'];
//$searchInput = "cowboy";
$searchInput = preg_replace("/\s+/", " ", $searchInput);
$searchInput = str_replace(" ", "%", $searchInput);
//$searchInput = "cowboy";


$query = "select b.title, b.edition, b.isbn_10, b.isbn_13 from user_profile a, book b, user_book ab where a.id = ab.user_id and b.id = ab.book_id and a.email = ?";
$params = array('s',$searchInput);

$result = DBConnection::processSQLStatement($query, $params, TRUE);
if ($result['error'] == null)
{
//$result = array("author" => $result['result']);
	foreach ($result['result'] as $k => $v) {
		//echo $v['title'];
		$query = "select a.name from author a, book b, author_book ab where a.id = ab.author_id and b.id = ab.book_id and b.title like CONCAT('%', ? ,'%')";
		$params = array('s',$v['title']);
		$result2 = DBConnection::processSQLStatement($query, $params, TRUE);
		if ($result2['error'] == null)
		{
			foreach($result2['result'] as $key => $value)
			{
				$result['result'][$k]['author'][$key] = $value; 
			}
			
		}
		//echo json_encode($result2);
	}
	echo json_encode($result);
	
}
else
{
echo json_encode($result);
}
	




	
?>