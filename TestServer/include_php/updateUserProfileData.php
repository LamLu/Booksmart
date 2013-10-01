<?php
require_once('../php/User.php');
require_once('../php/UploadUserProfileImage.php');

$email = $_POST['email'];
$updatedFirstName = $_POST['updatedFirstName'];
$updatedLastName = $_POST['updatedLastName'];
$updatedSchool = $_POST['updatedSchool'];
$updatedMajor = $_POST['updatedMajor'];

$user = User::constructWithUserProfile($email, $updatedFirstName, $updatedLastName, $updatedSchool, $updatedMajor);
$resultArr = $user->updateUserProfile();

if($resultArr['updated'] == "passed") //update user profile successfully
{
    $imageFile = $_FILES['uploadedImg'];
    $resultArr = UploadUserProfileImage::uploadImage($imageFile,$email);//update user profile image
    echo (json_encode($resultArr));
}
else echo (json_encode($resultArr));

?>