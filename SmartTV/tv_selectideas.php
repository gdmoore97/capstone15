<?php

// step 1: obtain the caregiver's username
$owner_username = htmlentities($_REQUEST["owner_username"]);

if (empty($owner_username)) {

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

// step 2: select events the user has created
$ideas = $access->selectIdeas($owner_username);

// step 3: if posts are found, append them to the $returnArray

if (!empty($ideas)) {
	$returnArray["ideas"] = $ideas;
}

// STEP 4: close connection
$access->disconnect();

// STEP 5: json data
echo json_encode($returnArray);


?>











