<?php
/**
 * php to represent a book object
 * @author Lam Lu
 */
class Book
{
	private $bookID = null;
	private $bookTitle = null;
	private $bookEdition = null;
	private $bookAuthors = null;
	private $bookISBN10 = null;
	private $bookISBN13 = null;
	private $bookPublisher = null;
	private $bookImgPath1 = null;
	private $bookImgPath2 = null;
	private $bookSubjects = null;
	
	/**
	 * constructor for book object
	 */
	public function __construct($id, $title, $edition, $authors, $isbn10, $isbn13, $publisher, $imgPath1, $imgPath2, $subjects)
	{
		$this->bookID = $id;
		$this->bookTitle = $title;
		$this->bookEdition = $edition;
		$this->bookAuthors = $authors;
		$this->bookISBN10 = $isbn10;
		$this->bookISBN13 = $isbn13;
		$this->bookPublisher = $publisher;
		$this->bookImgPath1 = $imgPath1;
		$this->bookImgPath2 = $imgPath2;
		$this->bookSubjects = $subjects;
	}
	
	/**
	 * function to return a json of the class
	 * @return json object of the class
	 */
	public function getJSONEncode() 
	{
    	return get_object_vars($this);
	}
}
?>