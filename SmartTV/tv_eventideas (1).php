<?php

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

$idea = $_GET['idea'];

$result = $access->addEventIdea($idea);

if ($result) {
	
	$returnArray["status"] = "200";
	$returnArray["message"] = "successfully registered the event suggestion";
	
	
} else {
	
	$returnArray["status"] = "400";
	$returnArray["message"] = "Could not register event suggestion";
	
}


$access->disconnect();


echo json_encode($returnArray);
?>
