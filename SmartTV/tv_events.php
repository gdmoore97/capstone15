<?php

//step 1: declare parms of user information
// securing information and storing variables
$eventname = htmlentities($_REQUEST["eventname"]);
$eventlocation = htmlentities($_REQUEST["eventlocation"]);
$eventdate = htmlentities($_REQUEST["eventdate"]);
$fullname = htmlentities($_REQUEST["fullname"]);
$creator_username = htmlentities($_REQUEST["creator_username"]);

// if get or post are empty
    // having issues with this if statement - code won't run with it in giving http 500 error
if (empty($eventname) || empty($eventlocation) || empty($fullname) || empty($eventdate) || empty($creator_username)) {

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

// STEP 3: Inser event information

$result = $access->addEvent($eventname, $eventlocation, $eventdate, $fullname, $creator_username);

if ($result) {
	
	$event = $access->selectEvent($eventname);
	
	$returnArray["status"] = "200";
	$returnArray["message"] = "successfully registered";
	$returnArray["id"] = $event["id"];
	$returnArray["eventname"] = $event["eventname"];
	$returnArray["eventlocation"] = $event["eventlocation"];
	$returnArray["eventdate"] = $event["eventdate"];
	$returnArray["fullname"] = $event["fullname"];
	$returnArray["creator_username"] = $event["creator_username"];
	
	
} else {
	
	$returnArray["status"] = "400";
	$returnArray["message"] = "Could not add event with provided information";
	
}


// STEP 4: close connection
$access->disconnect();

// STEP 5: json data
echo json_encode($returnArray);


?>