<?php
/**
* This is the processor for the book. 
*/
require_once("DBConnection.php");

class BookProcessor
{
	/*
	* function to retrieve books from user
	* @param $email the email of 
	* @return : array("error" : value, "result": array), the array result will contain all the rows fetched.
	*/
	public static function getBookFromUser($email)
	{
		$query = "SELECT title, edition FROM book b,user_book ub, user_profile up WHERE ub.user_id = up.id AND ub.book_id = b.id AND up.email = ?";
		$parameters =  array('s', $email);
		$result = DBConnection::processSQLStatement($query, $parameters, TRUE);
		return $result;		
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
			$authorArray, $subject)
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
			
			//insert book into user_book mapping table
			$query = "insert into user_book (user_id, book_id) values (?,?)";
			$statement = $conn->prepare($query);

			$statement->bind_param("ii", $userid, $bookid);
			if(!$statement->execute())
				$isSuccess = FALSE;
			$statement->close();
			
			//insert image path here
			/**********************
			 * 
			 * 
			 * 
			 * 
			 * 
			 * 
			 * 
			 * 
			 * 
			 ***********************/
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
			
		//subject not exist in author table
		if ($subjectid == null || $subjectid == 0)
		{
			//insert author
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
			return $bookid;
		}
		else 
		{
			$conn->rollback();
			$conn->close();
			return null;
		}
			
	}
}
?>