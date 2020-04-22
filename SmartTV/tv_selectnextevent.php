<?php

// step 1: obtain the caregiver's username
//$owner = htmlentities($_REQUEST["fullname"]);

/*
if (empty($owner)) {

	$returnArray["status"] = "400";
	$returnArray["message"] = "Missing information";
    echo json_encode($returnArray);
    return;
	
}
*/


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

// step 2: select events the user has created
$events = $access->selectNextEvent();

// step 3: if posts are found, append them to the $returnArray

if (!empty($events)) {
	$returnArray["events"] = $events;
}

// STEP 4: close connection
$access->disconnect();

// STEP 5: json data
echo json_encode($returnArray);


?>