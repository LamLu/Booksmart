<?php
/**
 * This is a static class to create the connection to database
 * @author Lam Lu
 * @copyright 2013 @ HiDev Mobile
 */
class DBConnection
{
    private static $db_server = "localhost";
    private static $db_username = "wttuser";
    private static $db_password = "changeme";
    private static $db_name = "WTT_Schema";
    private static $conn = null;    
    
    
    /**
     *function to create the connection
     *@return conn if success, null otherwise
     */
    public static function createConnection()
    {
        self::$conn = new mysqli(self::$db_server,self::$db_username, 
        		self::$db_password, self::$db_name);
        if(mysqli_connect_errno())//error connecting
        {
            echo("error connecting");
            return null;
        }
        return self::$conn;
    }
    
    /**
     *function to close the connection
     */
    public static function closeConnection()
    {
        if (self::$conn != null)
            self::$conn->close();
    }
    
    /**
     * process the SQL Statement
     * @param String $query the query to be processed
     * @param $paramArr the param to be bound, formated by array(param type, params,....)
     * @param $needFetch boolean to determine if need to fetch the query, true means need to fetch, false means no need
     * @return array("error" : value, "result": array of json object), the array result will contain all the rows fetched in json format.
     */
    public static function processSQLStatement ($query,$paramArr, $needFetch)
    {
	
    	$conn = DBConnection::createConnection();
  	
    	$resultArray = array("error" => null, "result" => null);
    	
    	if($conn === null)//fail to connect
    	{
    		$resultArray['error'] = "Failed to connect to database";
    		return $resultArray;
    	}
  
    	$statemetstatemet = $conn->stmt_init();
    	$statement = $conn->prepare($query);
 	
    	//failed to prepare
    	if ($statement == false)
    	{
    		$resultArray['error'] = "Failed to prepare statement";
    		DBConnection::closeConnection();
    		return $resultArray;
    	}
	
  
		if (call_user_func_array(array($statement, 'bind_param'), DBConnection::refValues($paramArr)) == false)
        {
    		$resultArray['error'] = "Failed to bind data";
    		DBConnection::closeConnection();
    		return $resultArray;
    	}			
    
    	if($statement->execute() == false)//fail to execute
    	{
    		$resultArray['error'] =  "Failed to execute query";
    		DBConnection::closeConnection();    			
    		return $resultArray;
    	} 	
 
    	if ($needFetch == FALSE)
    	{
    		$resultArray['error'] = null;
    		$resultArray['result'] = null;
    		DBConnection::closeConnection();
    		return $resultArray;
    	}

		$bindDataArray = array();

    	if (DBConnection::bind_array($statement, $bindDataArray) == false)
    	{
    		$resultArray['error'] = "Failed to bind data";
    		DBConnection::closeConnection();
    		return $resultArray;
    	}
    		
		/*
    	if ($statement->fetch() == false)
    	{
    		$resultArray['error'] = "Failed to fetch data";
    		DBConnection::closeConnection();
    		return $resultArray;
    	}
		*/
		
		$resultMap = new ArrayObject();
		while ($statement->fetch())
		{
			$resultMap->append(json_decode(json_encode($bindDataArray), true));
		}
    	DBConnection::closeConnection();
    	$resultArray['error'] = null;
    	$resultArray['result'] = $resultMap;
 
    	return $resultArray;
    }
    
    /**
     * return an array of element reference of the original array
     * @param array $arr the original array
     * @return array of reference
     */
     public static function refValues($arr)
     {
    	if (strnatcmp(phpversion(),'5.3') >= 0) //Reference is required for PHP 5.3+
    	{
    		$refs = array();
    		foreach($arr as $key => $value)
    			$refs[$key] = &$arr[$key];
    		return $refs;
    	}
    	return $arr;
    }
    
    /**
     * return an array of bind data
     * @param Statement $stmt the SQL statement to be execute
     * @param array $row the reference to the array
     * @return true if data is bound, false otherwise
     */
    public static function bind_array($stmt, &$row)
    {
  
    	$md = $stmt->result_metadata();
    	$params = array();
    	while($field = $md->fetch_field()) 
    	{
    		$params[] = &$row[$field->name];
    	}
    	if (call_user_func_array(array($stmt, 'bind_result'), $params) === false)
    		return false ;
    	else return true;
    }
}
?>