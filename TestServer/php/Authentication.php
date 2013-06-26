<?php
require_once("DBConnection.php");

/**
 * This class is used as a wrapper for the login 
 * pass in email or username and password to construct the 
 * Authentication class. This class is also to be responsible
 * for verifying if successful login and password
 * @author Lam Lu
 */
class Authentication
{
	private $email;
	private $password;
	private $salt;
	
	/**
	 * constructor for the class
	 * @param $e the email
	 * @param $pass the pass
	 */
	function __construct ($e, $pass)
	{
		$this->email = $e;
		$this->password = $pass;
		$salt = null;
	}
	
	/**
	 * destructor for the class
	 */
	function __destruct()
	{
		$email = null;
		$password = null;
		$salt = null;
	}
	
	/**
	 * function to log in 
	 * @return false when failed to login, true otherwise
	 */
	public function login()
	{
		if(empty($this->email) || empty($this->password)) //if empty
			return false;
		
		$conn = DBConnection::createConnection();
		if($conn === null)//fail to connect
		{
			echo "Failed to Connect to database";
			return false;
		}
		

	
		//prepare only works for 1 sql statement. It's good to prevent SQL injection
		//SQL injection example: "select * from table where col1 = :col1"
		//then the hacker can inject the (":col1", "i'm hacker; delete * from table")
		//this example does not work on this case since prepare will throw error because there
		//are 2 SQL Statements
		$statement = $conn->prepare('Select email, password, 
				salt from user_profile where email = ?');


		
		//failed to prepare
		if ($statement == false)
		{
			echo "Failed to prepare statement";
			return false;
		}
		
		

		if ($statement->bind_param("s", $this->email) == false) //error binding data
		{
			echo "Failed to bind data";
			return false;
		}
		
		if($statement->execute() == false)//fail to execute
		{
			echo "Failed to execute query";
			return false;
		}
		

		//bind result variables
		//Note that all column must be bound after statement execute and before statment fetch
		if ($statement->bind_result($resultEmail, 
				$resultPassword, $resultSalt) == false) //failed binding
		{
			echo "Failed to bind result";
			return false;
		}
		$statement->fetch();		
		
		if($resultPassword == hash("sha512", $this->password.$resultSalt))
			return true;
		else
			return false;
		
		
		DBConnection::closeConnection();		
	}

	/**
	 * function to retrieve the user profile
	 */
	public function retrieveUserProfile()
	{
		if(empty($this->email)) //if empty
			return null;
		
		$conn = DBConnection::createConnection();
		if($conn === null)//fail to connect
		{
			echo "Failed to Connect to database";
			return null;
		}
		
		
		//prepare only works for 1 sql statement. It's good to prevent SQL injection
		//SQL injection example: "select * from table where col1 = :col1"
		//then the hacker can inject the (":col1", "i'm hacker; delete * from table")
		//this example does not work on this case since prepare will throw error because there
		//are 2 SQL Statements
		$statement = $conn->prepare('Select email, first_name, last_name, school, major,
				profile_img_src from user_profile where email = ?');

		//failed to prepare
		if ($statement == false)
		{
			echo "Failed to prepare statement";
			return false;
		}
	
	
		if ($statement->bind_param("s", $this->email) == false) //error binding data
		{
			echo "Failed to bind data";
			return false;
		}
	
		if($statement->execute() == false)//fail to execute
		{
			echo "Failed to execute query";
			return false;
		}
		
		//bind result variables
		//Note that all column must be bound after statement execute and before statment fetch
		if ($statement->bind_result($resultEmail, $resultFirstName, 
				$resultLastName, $resultSchool, $resultMajor, $profileImgSrc) == false) //failed binding
		{
			echo "Failed to bind result";
			return false;
		}
		$statement->fetch();
		$userProfile = array("userEmail" => $resultEmail, "userFirstName" => $resultFirstName, "userLastName" => $resultLastName,
							"userSchool" => $resultSchool, "userMajor"=> $resultMajor, "userProfileImgSrc" => $profileImgSrc);
	
	
	
		DBConnection::closeConnection();
	    return $userProfile;
		
	}
}
?>