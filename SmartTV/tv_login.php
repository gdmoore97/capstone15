<?php

// STEP 1: Check variables
$username = htmlentities($_REQUEST["username"]);
$password = htmlentities($_REQUEST["password"]);

if (empty($username) || empty($password)){
	$returnArray["status"] = "400";
	$returnArray["message"] = "Missing required information";
	echo json_encode($returnArray);
	return;
}

// STEP 2: Build connection_aborted
$file = parse_ini_file("new.ini");

// store in php var_dump
$host = trim($file["dbhost"]);
$user = trim($file["dbuser"]);
$pass = trim($file["dbpass"]);
$name = trim($file["dbname"]);

// include access.php
require("tv_access.php");
$access = new access($host, $user, $pass, $name);
$access->connect();

// step 3: get user's information
$user = $access->getUser($username);

// if there's no user info
if (empty($user)){

	$returnArray["status"] = "403";
	$returnArray["message"] = "user is not found";
	echo json_encode($returnArray);
	return;

}

//step 4: check validity of entered password

// get password and salt from db
$secured_password = $user["password"];
$salt = $user["salt"];

// check if passwords match from db and entered
if ($secured_password == sha1($password . $salt)){
	
	$returnArray["status"] = "200";
	$returnArray["message"] = "Logged in successfully";
	$returnArray["id"] = $user["id"];
	$returnArray["username"] = $user["username"];
	$returnArray["fullname"] = $user["fullname"];
	$returnArray["role"] = $user["role"];
	$returnArray["owner_fullname"] = $user["owner_fullname"];
    $returnArray["owner_username"] = $user["owner_username"];
	
} else {
	$returnArray["status"] = "403";
	$returnArray["message"] = "Passwords do not match";
}

// STEP 5: close connection
$access->disconnect();

//STEP 6: return info to user
echo json_encode($returnArray);

?>