<?php

//step 1: declare parms of user information
// securing information and storing variables
$owner_fullname = htmlentities($_REQUEST["owner_fullname"]);
$owner_username = htmlentities($_REQUEST["owner_username"]);
$username = htmlentities($_REQUEST["username"]);


// if get or post are empty
    // having issues with this if statement - code won't run with it in giving http 500 error
if (empty($owner_fullname) || empty($owner_username) || empty($username)) {

	$returnArray["status"] = "400";
	$returnArray["message"] = "Missing information";
    echo json_encode($returnArray);
    return;
	
}
    
//build secure connection

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

// STEP 3: Inser user information

$result = $access->addCaregiverInfo($owner_fullname, $owner_username, $username);

if ($result) {
	
	$user = $access->selectUser($username);
	
	$returnArray["status"] = "200";
	$returnArray["message"] = "successfully registered";
	$returnArray["id"] = $user["id"];
	$returnArray["username"] = $user["username"];
	$returnArray["fullname"] = $user["fullname"];
	$returnArray["role"] = $user["role"];
	$returnArray["owner_fullname"] = $user["owner_fullname"];
	$returnArray["owner_username"] = $user["owner_username"];
	
	
} else {
	
	$returnArray["status"] = "400";
	$returnArray["message"] = "Could not register with provided information";
	
}


// STEP 4: close connection
$access->disconnect();

// STEP 5: json data
echo json_encode($returnArray);


?>