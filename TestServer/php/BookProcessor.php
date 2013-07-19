<?php
/**
* This is the processor for the book. 
*/
require_once("DBConnection.php");
require_once("Book.php");
define ("MAX_FILE_SIZE", "500");
class BookProcessor
{
	/*
	* function to retrieve books from user
	* @param $email the email of 
	* @return : array("error" : value, "result": array), the array result will contain all the rows fetched.
	*/
	public static function getBookFromUser($email)
	{
		$query = "SELECT b.*, ub.img_path_1, ub.img_path_2  FROM book b,user_book ub, user_profile up
				WHERE ub.user_id = up.id AND ub.book_id = b.id AND up.email = ?";
		$parameters =  array('s', $email);
		$resultArray = DBConnection::processSQLStatement($query, $parameters, TRUE);

		$bookArray = array();
		foreach ($resultArray['result'] as $bookObject)
		{
			$id = $bookObject['id'];
			$title = $bookObject['title'];
			$edition = $bookObject['edition'];
			$isbn10 = $bookObject['isbn_10'];
			$ibsn13 = $bookObject['isbn_13'];
			$publisher = $bookObject['publisher'];
			$imgPath1 = $bookObject['img_path_1'];
			$imgPath2 = $bookObject['img_path_2'];

			//for each book, get the authors
			$query = null;
			$query = "SELECT a.name from author a, author_book ab WHERE ab.book_id = ? AND a.id = ab.author_id";
			$parameters = null;
			$parameters = array('d', $id);
			$resultArray = null;
			$resultArray = DBConnection::processSQLStatement($query, $parameters, TRUE);
			$authors = array();
			foreach ($resultArray['result'] as $author)
			{
				array_push($authors, $author['name']);
			}
			
			//for each book. get the subjects
			$query = null;
			$query = "SELECT s.title from subject s, subject_book sb WHERE sb.book_id = ? AND s.id = sb.subject_id";
			$parameters = null;
			$parameters = array('d', $id);
			$resultArray = null;
			$resultArray = DBConnection::processSQLStatement($query, $parameters, TRUE);
			$subjects = array();
			foreach ($resultArray['result'] as $subject)
			{
				array_push($subjects, $subject['title']);
			}

			$book = new Book($id, $title, $edition, $authors, $isbn10, $isbn13, $publisher, $imgPath1, $imgPath2, $subjects);
			array_push($bookArray, $book->getJSONEncode());
			//echo(json_encode($book->getJSONEncode()));
		}
		
		return $bookArray;		
	}
	
	/*
	* function to retrieve books from author
	* @param author information
	* @return : array("error" : value, "result": array), the array result will contain all the rows fetched.
	*/
	public static function getBookFromAuthor($authorFirstName, $authorLastName)
	{
		$query = "SELECT title FROM author a, book b, author_book ab WHERE a.id = ab.author_id AND ab.book_id = b.id AND (a.first_name LIKE CONCAT ('%',?,'%') OR a.last_name LIKE CONCAT ('%', ?, '%'))";
		$parameters = array('ss', $authorFirstName, $authorLastName);
		$result = DBConnection::processSQLStatement($query, $parameters, TRUE);
		return $result;		
	}
	
	/*
	* function to retrieve books from subject
	* @param author information
	* @return : array("error" : value, "result": array), the array result will contain all the rows fetched.
	*/
	public static function getBookFromSubject ($subject)
	{
		$query = "select b.title from book b, subject s, subject_book sb where s.id = sb.subject_id and sb.book_id = b.id and s.title LIKE CONCAT('%', ?, '%')";
		$parameters = array("s", $subject);
		$result = DBConnection::processSQLStatement($query, $parameters, TRUE);
		return $result;
	}
	
	/**
	 * function to insert the books to database
	 * 
	 */
	public static function insertBook($email, $bookTitle, $bookEdition, $isbn10, $isbn13, $publisher,
			$authorArray, $subject, $firstImage, $secondImage)
	{
		
		$conn = DBConnection::createConnection();
		$isSuccess = TRUE;
		if(!conn)
			die('Connect Error');
		
		
		//turn off auto commit to use transaction
		$conn->autocommit(FALSE);
		$query = "select id from user_profile where email = ?";
		$statement = $conn->prepare($query);
		$statement->bind_param("s", $email);
		
		/**
		 * block to get user id
		 */
		//failed to execute
		if(!$statement->execute())
			$isSuccess = FALSE;
		$userid = null;
		$statement->bind_result($userid);
		
		//failed to fetch
		if(!$statement->fetch())
			$isSuccess = FALSE;
		$statement->close();

		/**
		 * block to get book id
		 */
		$query = "select id from book where (title = ? AND edition = ?) 
				or isbn_10 = ? or isbn_13 = ?";
		$statement = $conn->prepare($query);
		$statement->bind_param("ssss",trim($bookTitle), trim($bookEdition), trim($isbn10),
				trim($isbn13));
		if(!$statement->execute())
			$isSuccess = FALSE;
		$bookid = null;
		$statement->bind_result($bookid);
		$statement->fetch();
		$statement->close();	
		
		/**
		 * if book found, increase quantity by 1
		 */
		if ($bookid != null)
		{
			$query = "update book set quantity = quantity + 1 where id = ?";
			$statement = $conn->prepare($query);
			
			$statement->bind_param ("i",$bookid );
			if(!$statement->execute())
				$isSuccess = FALSE;
			$statement->close();	
		
		}
		
		/**
		 * book not found, insert new book into database
		 */
		else
		{
			//insert book into book table
			$query = "insert into book (title, edition, isbn_10, isbn_13, quantity, publisher) values (?,?,?,?,?,?)";
			$statement = $conn->prepare($query);
			$quantity = 1;
			$statement->bind_param("ssssss",trim($bookTitle), trim($bookEdition), trim($isbn10),
				trim($isbn13), $quantity ,trim($publisher));
			if(!$statement->execute())
				$isSuccess = FALSE;
			$statement->close();
			
			//get the id that was just inserted
			$bookid = null;
			$bookid = $conn->insert_id;
			
			//insert author
			foreach($authorArray as $author)
			{
				$authorid = null;
				$query = "select id from author where name = ?";
				$statement = $conn->prepare($query);
				$statement->bind_param("s", trim($author));
				if(!$statement->execute())
					$isSuccess = FALSE;
				$statement->bind_result($authorid);
				$statement->fetch();
				$statement->close();
				
				
				//author not exist in author table
				if ($authorid == null || $authorid == 0)
				{
					//insert author
					$query = "insert into author (name) values (?)";
					$statement = $conn->prepare($query);
					$statement->bind_param("s", trim($author));
					if(!$statement->execute())
						$isSuccess = FALSE;
					$statement->close();
					$authorid = $conn->insert_id;
					
				}

				$query = "insert into author_book(author_id, book_id) values (?,?)";
				$statement = $conn->prepare($query);
				$statement->bind_param("ii", $authorid, $bookid);
				if(!$statement->execute())
					$isSuccess = FALSE;
				$statement->close();
				
			} 
			
		}

		//insert book into user_book mapping table
		$query = "insert into user_book (user_id, book_id) values (?,?)";
		$statement = $conn->prepare($query);

		$statement->bind_param("ii", $userid, $bookid);
		if(!$statement->execute())
			$isSuccess = FALSE;
		$statement->close();
		
		$ubid = null;
		$ubid = $conn->insert_id;
		
		/**
		 * insert subject into table
		 */
			
		$subjectid = null;
		$query = "select id from subject where title = ?";
		$statement = $conn->prepare($query);
		$statement->bind_param("s", trim($subject));
		if(!$statement->execute())
			$isSuccess = FALSE;
		$statement->bind_result($subjectid);
		$statement->fetch();
		$statement->close();
			
		//subject not exist in subject table
		if ($subjectid == null || $subjectid == 0)
		{
			//insert subject
			$query = "insert into subject (title) values (?)";
			$statement = $conn->prepare($query);
			$statement->bind_param("s", trim($subject));
			if(!$statement->execute())
				$isSuccess = FALSE;
			$statement->close();
			$subjectid = $conn->insert_id;
		}
			
		$query = "insert into subject_book(subject_id, book_id) values (?,?)";
		$statement = $conn->prepare($query);
		$statement->bind_param("ii", $subjectid, $bookid);
		$statement->execute();
		$statement->close();
		
		if($isSuccess)
		{
			$conn->commit();
			$conn->autocommit(TRUE);
			$conn->close();
			
			if ($firstImage != null)
			{
				$retrievedAttr = null;
				$retrievedAttr = "img_path_1";
				BookProcessor::uploadImage($firstImage, $ubid, $retrievedAttr);
			}
			
			if ($secondImage != null)
			{
				$retrievedAttr = null;
				$retrievedAttr = "img_path_2";
				BookProcessor::uploadImage($secondImage, $ubid, $retrievedAttr);
			}
	
			return array("error"=>null);
		}
		else 
		{
			$conn->rollback();
			$conn->close();
			return array("error"=>"Error uploading book");
		}
			
	}
	
	/**
	 * function to upload book image to user_book table
	 * @param unknown $imageFile
	 * @param unknown $userEmail
	 * @return multitype:NULL string |multitype:NULL string Ambigous <NULL, string, NULL, NULL, ArrayObject>
	 */
	public static function uploadImage($imageFile, $id, $retrievedAttr)
	{
		
		$imageName = $imageFile['name'];
		$updatedResultArr = array("updated" => null, "error" =>null);
		
		$whitelist = array("gif", "jpeg", "jpg", "png");
		$ext = strtolower(BookProcessor::getExt($imageName));
		
		//no extension
		if($ext === FALSE)
		{
			$updatedResultArr['updated'] = "failed";
			$updatedResultArr['error'] = "File has no extension";
			return $updatedResultArr;
		}
		
		$extMatch = FALSE;
		foreach($whitelist as $value)
		{
			if (strcasecmp($ext, $value) == 0)
				$extMatch = TRUE;
		}
		unset($value);
		
		//using extension that is not allowed
		if ($extMatch === FALSE)
		{
			$updatedResultArr['updated'] = "failed";
			$updatedResultArr['error'] = "Only gif, jpeg, jpg or png are allowed";
			return $updatedResultArr;
		}
						
		//not allow to upload image > 500kb
		if($imageFile['size'] > MAX_FILE_SIZE * 1024)
		{
			$updatedResultArr['updated'] = "failed";
			$updatedResultArr['error'] = "Image size exceeded 500Kb";
			return $updatedResultArr;
		}
	
	
		//get the path to store the image
		$query = "select ".$retrievedAttr." from user_book where id = ?";
		$paramArr = array('d', $id);		
		$resultArray = DBConnection::processSQLStatement($query, $paramArr, TRUE);

	
		//failed to process the statement
		if ($resultArray['error'] != null)
		{
			$updatedResultArr['updated'] = "failed";
			$updatedResultArr['error'] = $resultArray['error'];
			return $updatedResultArr;
		}
				
		$imgsrc = $resultArray['result']['0'][$retrievedAttr];

		//give a unique new name for the image
		$newImgName = rand(1,time()).".".$ext;
		
		if($imgsrc == NULL)
		{
			$targetPath = $_SERVER['DOCUMENT_ROOT']."/book_img/".$newImgName;	
			$query = "update user_book set ".$retrievedAttr." = ? where id = ?";

			$paramArr = array('sd', "/book_img/".$newImgName,$id);
			DBConnection::processSQLStatement($query, $paramArr, FALSE);
			
		}
		
		else 
		{
			
			$targetPath = $_SERVER['DOCUMENT_ROOT'].$imgsrc;
		}
		
		if (move_uploaded_file($imageFile['tmp_name'], $targetPath))
		{
			$updatedResultArr['updated'] = "passed";
			$updatedResultArr['error'] = null;
			return $updatedResultArr;
		}
		else
		{
			$updatedResultArr['updated'] = "failed";
			$updatedResultArr['error'] = 'Cannot move file to target path';
			return $updatedResultArr;
		}
		
	}

	//read the extension of the file
	public static function getExt($str)
	{
		$pos = strrpos($str, ".");
		if($pos === FALSE)
			return FALSE;
		$len = strlen($str) - $pos;
		$ext = substr($str, $pos + 1, $len);
		return $ext;
	}
}
?>