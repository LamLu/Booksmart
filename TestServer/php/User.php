<?php
/**
 *This class connect to database and register user
 *@author Chien Nguyen, modified by Lam Lu
 *@copyright Copyright (c) 2013, HiDev Mobile
 */
require_once("DBConnection.php");


class User
{
	private $email;
	private $password;
	private $firstname;
	private $lastname;
	private $school;
	private $major;

	//default constructor
	function __construct()
	{
		$this->email = null;
		$this->password = null;
		$this->firstname = null;
		$this->lastname = null;
		$this->school = null;
		$this->major = null;

	}
	//destruct
	function __destruct()
	{
		$this->email = null;
		$this->password = null;
		$this->firstname = null;
		$this->lastname = null;
		$this->school = null;
		$this->major = null;
	}
	
	//static helper to construct object with email and password
	//@param: $email the email to be set
	//@param: $password the password to be set
	public static function constructWithEmailPassword($email, $password)
	{
		$instance = new self();
		$instance->email = $email;
		$instance->password= $password;
		return $instance;		
	}
	
	/**
	 * static helper to construct object with user profile
	 * @param varchar $email
	 * @param varchar $firstname
	 * @param varchar $lastname
	 * @param varchar $school
	 * @param varchar $major
	 * @return instance of the class User
	 */
	public static function constructWithUserProfile($email, $firstname, $lastname,$school,$major)
	{
		$instance = new self();
		$instance->email = $email;
		$instance->firstname = $firstname;
		$instance->lastname = $lastname;
		$instance->school = $school;
		$instance->major = $major;
		return $instance;
	}
	
	/**set email field
	*/
	function setEmail($e)
	{
		$this->email = $e;
	}
	/** set password field
	*/
	function setPassword($p)
	{
		$this->password = $p;
	}
	
	
	/** Check if user already register
	* return true if user exist or fail to connect to database
	**/
	public function alreadyRegister()
	{
    	$conn = DBConnection::createConnection();
		$check = true;
		
    	if($conn !== null) //successfully connected to database
    	{		
			//prepare statement				
			if ($statement = $conn->prepare('Select email from user_profile where email = ?'))
			{
				$statement->bind_param("s", $this->email);
				$statement->execute();
        		$statement->store_result();
				
				// If the user exists
				if($statement->num_rows == 1) $check=true;
				else $check=false; 
			}
			else echo "Failed to prepare statement";	
		}

		//close connection
		DBConnection::closeConnection();
		return $check;
	}
	
	/** 
	 * Register a user
	* Pre: user not register yet
	* Post: user registered; email, hashpassword and salt save to database
	*/
	public function register()
	{
		$check = false;
    	$conn = DBConnection::createConnection();
		//create a random salt with min and max value, the salt is unique
		$salt = uniqid(mt_rand(1,mt_getrandmax()),true);
		//hash password
		$hashPass = hash('sha512', $this->password.$salt);
		
    	if($conn !== null) //successfully connected to database
    	{
			if($insert_statement = $conn->prepare('INSERT INTO user_profile (email, password, salt) VALUES (?, ?, ?)'))
			{
				$insert_statement->bind_param("sss", $this->email, $hashPass, $salt);
				$insert_statement->execute();
				$check= true;
			}
			else echo "Failed to prepare statement";
		}

		//close connection
		DBConnection::closeConnection();
		return $check;
	}
	
	/**
	 * function to change user profile
	 * @return $resultArray, array is format as ("updated": value, "error" :value)
	 * retun "updated": Failed , "error": ... if failed
	 * "udpated" :Passed, "error": null if passed 
	 */
	public function updateUserProfile()
	{
		$query = "update user_profile set first_name = ?, last_name = ?, school = ?, major = ? where email = ?";
		$paramArr = array('sssss', $this->firstname, $this->lastname, $this->school, $this->major, $this->email);
		$resultArray= DBConnection::processSQLStatement($query, $paramArr, FALSE);
		if ($resultArray['error'] == null)
		    return array('updated' => 'passed', 'error' => null);
	        else return array('updated'=> 'failed', 'error' => $resultArray['error']);
	}
}
?>