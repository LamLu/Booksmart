<?php

require_once("DBConnection.php");

/**
 * The functionality of the Message class is to fetch messages from the database.
 * @author Lam Lu, Tyler Stennette, Dhruv Mevada, Shivalik Narad 
 * @copyright 2013 HiDev Mobile
 */
class Message
{
	/**
	 * The functionality of getInbox retrieves the messsages between users. 
	 */
	public static function getInbox($email)
	{
		$query = "select email from user_profile where id in (select receiver_id from user_profile up, message where email = ? and sender_id = up.id) or id in (select sender_id from user_profile up, message where email = ? and receiver_id = up.id)";
		$resultArray = array('ss', $email, $email);
		$result = DBConnection::processSQLStatement ($query, $resultArray, TRUE);
		return $result;
	}
	/**
	 * Retrieves messages exchanged between 2 users. 
	 */
	public static function getConversation($s_email, $r_email)
	{
		$query = "select sender.email as sender_email, receiver.email as receiver_email, m.content from message m join user_profile sender on sender.id = m.sender_id join user_profile receiver on receiver.id = m.receiver_id where (sender.email = ? and receiver.email = ?) or (sender.email = ? and receiver.email = ?) order by m.date asc";
		$resultArray = array('ssss', $s_email, $r_email,$r_email, $s_email);
		$result = DBConnection::processSQLStatement ($query, $resultArray, TRUE);
		return $result;
	}

	/**
	 * This function inserts every message into the database.
	 */
	public static function insertMessage($message, $owner_email, $receiver_email)
	{
		$query = "INSERT INTO message (sender_id, receiver_id, content) VALUES ((SELECT id FROM user_profile WHERE email = ?), (SELECT id FROM user_profile WHERE email = ?), ?)";
		$parameterArray = array('sss', $owner_email, $receiver_email, $message);
		$result = DBConnection::processSQLStatement($query, $parameterArray, FALSE);
		return $result;
	}
}
?>