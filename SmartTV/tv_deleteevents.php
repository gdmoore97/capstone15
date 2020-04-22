<?php


// php function to delete event

// get id of event 
$id = htmlentities($_REQUEST["id"]);

if (empty($id)) {

	$returnArray["status"] = "400";
	$returnArray["message"] = "Missing information";
    echo json_encode($returnArray);
    return;
	
}

// store in php var information from ini file
$file = parse_ini_file("new.ini");
$host = trim($file["dbhost"]);
$user = trim($file["dbuser"]);
$pass = trim($file["dbpass"]);
$name = trim($file["dbname"]);

// include acc.php to call function within acc.php file
require("tv_access.php");
$access = new access($host, $user, $pass, $name);
$access->connect();

// delete event with the specific id
$result = $access->deleteEvent($id);

if (!empty($result)){
	
	$returnArray["message"] = "Successfully deleted post";
	$returnArray["result"] = $result;
	
} else {
	$returnArray["message"] = "Could not delete post";

// STEP 4: close connection
$access->disconnect();

// STEP 5: json data
echo json_encode($returnArray);

}


?>