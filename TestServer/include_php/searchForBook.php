<?php
require_once("../php/DBConnection.php");


$searchInput = $_POST['book'];
$searchScope = $_POST['scope'];
$searchInput = preg_replace("/\s+/", " ", $searchInput);
$searchInput = str_replace(" ", "%", $searchInput);

/*
$searchInput = 'kite';
$searchScope = 'Title';
$searchInput = 'lam%lu';
$searchScope = 'Author';
$searchInput = '31';
$searchScope = 'ISBN10';
$searchInput = '3';
$searchScope = 'ISBN13';
*/
/*
$searchInput = 'in';
$searchScope = 'Title';
$searchInput = 'lam';
$searchScope = 'Author';
*/
if ($searchScope == 'Title')
{

//echo $query;
$query = "select title, edition, isbn_10, isbn_13 from book where title like CONCAT('%', ? ,'%')";
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
	
}
else if ($searchScope == 'Author')
{
$query = "select b.title, b.edition, b.isbn_10, b.isbn_13 from author a, book b, author_book ab where a.id = ab.author_id and b.id = ab.book_id and a.name like CONCAT('%', ? ,'%')";
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
	
}
else if ($searchScope == 'ISBN')
{
$query = "select b.title, b.edition, b.isbn_10, b.isbn_13 from book where b.isbn_10 = ? or b.isbn_13  = ?";
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
	
	
}


	
?>