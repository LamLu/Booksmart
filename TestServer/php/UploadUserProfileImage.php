<?php
/**
 * the class to upload user profile image
 * @author lamlu
 */
require_once ("DBConnection.php");
define ("MAX_FILE_SIZE", "500");
Class UploadUserProfileImage
{
	/**
	 * static function to upload user profile
	 * @param $imageFile the _FILE['image'];
	 * @param $userEmail the user email
	 * @return no error if upload successfully, error otherwise
	 */
	public static function uploadImage($imageFile, $userEmail)
	{
		
		$imageName = $imageFile['name'];
		$updatedResultArr = array("updated" => null, "error" =>null);
		
			
		$whitelist = array("gif", "jpeg", "jpg", "png");
		$ext = strtolower(UploadUserProfileImage::getExt($imageName));		
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
		$query = "select profile_img_src from user_profile where email = ?";
		$paramArr = array('s',$userEmail);		
		$resultArray = DBConnection::processSQLStatement($query, $paramArr, TRUE);

		
		//failed to process the statement
		if ($resultArray['error'] != null)
		{
			$updatedResultArr['updated'] = "failed";
			$updatedResultArr['error'] = $resultArray['error'];
			return $updatedResultArr;
		}
	
		
		$imgsrc = $resultArray['result']['profile_img_src'];
		
		//give a unique new name for the image
		$newImgName = time().".".$ext;
		
		if($imgsrc == NULL)
		{
			$targetPath = $_SERVER['DOCUMENT_ROOT']."/profile_img/".$newImgName;	
			$query = "update user_profile set profile_img_src = ? where email = ?";
			$paramArr = array('ss', "/profile_img/".$newImgName,$userEmail);
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