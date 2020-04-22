<?php

//step 1: declare parms of user information
// securing information and storing variables
$username = htmlentities($_REQUEST["username"]);
$password = htmlentities($_REQUEST["password"]);
$fullname = htmlentities($_REQUEST["fullname"]);
$role = htmlentities($_REQUEST["role"]);
$owner_fullname = htmlentities($_REQUEST["owner_fullname"]);
$owner_username = htmlentities($_REQUEST["owner_username"]);

// if get or post are empty
    // having issues with this if statement - code won't run with it in giving http 500 error
if (empty($username) || empty($password) || empty($fullname) || empty($role) || empty($owner_fullname) || empty($owner_username)) {

	$returnArray["status"] = "400";
	$returnArray["message"] = "Missing information";
    echo json_encode($returnArray);
    return;
	
}
    
// secure password
//$salt = openssl_random_psuedo_bytes(20);
$salt = openssl_random_pseudo_bytes(20);
$secured_password = sha1($password . $salt);

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

// step 2: get owner user's information
$owner_user = $access->getUserOwner($owner_username);

// if there's no user info
if (empty($owner_user)) {

    $returnArray["status"] = "403";
    $returnArray["message"] = "Owner user information is not found";
    echo json_encode($returnArray);
    return;
} else {

    // STEP 3: Inser user information
    
    $result = $access->registerUserCaregiver($username, $secured_password, $salt, $fullname, $role, $owner_fullname, $owner_username);
    
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
}


// STEP 4: close connection
$access->disconnect();

// STEP 5: json data
echo json_encode($returnArray);


?>