<?php



// declare a class to access this php file
class access {


	// connection global variables
	var $host = null;
	var $user = null;
	var $password = null;
	var $name = null;
	var $conn = null;
	var $result = null;


	//constructing class
	function __construct($dbhost, $dbuser, $dbpass, $dbname) {

		$this->host = $dbhost;
		$this->user = $dbuser;
		$this->pass = $dbpass;
		$this->name = $dbname;

	}

	// connection function
	public function connect() {

		// establishes connection and stores it in conn variable
		$this->conn = new mysqli($this->host, $this->user, $this->pass, $this->name);

		// if error
		if (mysqli_connect_errno()) {
			// echo 'Could not connect to database';
		} else {
		    // echo "Connected";
		}
		  

		// supports all languages
        $this->conn->set_charset("utf8");

	}


	// disconnection function
	public function disconnect(){

		if ($this->conn != null){
			
			$this->conn->close();

		}

	}
	
	// Insert user details
	public function registerUserOwner($username, $password, $salt, $fullname, $role){
		
		// sql command
		$sql = "INSERT INTO tvusers SET username=?, password=?, salt=?, fullname=?, role=?";
		
		// store sql result in statement
		$statement = $this->conn->prepare($sql);
		
		// if error
		if (!$statement){
			throw new Exception($statement->error);
		}
		
		// bind 5 parameters of type string to be placed in sql command
		$statement->bind_param("sssss", $username, $password, $salt, $fullname, $role);
		
		$returnValue = $statement->execute();
		
		return $returnValue;
	}
	
	
	
	// Insert user details for a caregiver
	public function registerUserCaregiver($username, $password, $salt, $fullname, $role, $owner_fullname, $owner_username){
		
		// sql command
		$sql = "INSERT INTO tvusers SET username=?, password=?, salt=?, fullname=?, role=?, owner_fullname=?, owner_username=?";
		
		// store sql result in statement
		$statement = $this->conn->prepare($sql);
		
		// if error
		if (!$statement){
			throw new Exception($statement->error);
		}
		
		// bind 5 parameters of type string to be placed in sql command
		$statement->bind_param("sssssss", $username, $password, $salt, $fullname, $role, $owner_fullname, $owner_username);
		
		$returnValue = $statement->execute();
		
		return $returnValue;
	}

	
	// select user information
	public function selectUser($username){
		
		$sql = "SELECT * FROM tvusers WHERE username='" .$username. "'";
		
		// assign result from sql to result var
		$result = $this->conn->query($sql);
		
		// if there is at least one result returned
		if ($result != null && (mysqli_num_rows($result) >=1)){
			
			// assign results we got to $row as associatative array
			$row = $result->fetch_array(MYSQLI_ASSOC);
		
			if (!empty($row)) {
				$returnArray = $row;
			}
		}
		
		return $returnArray;
		
		
	}
	
	// get any and all users
	public function getUser($username) {
	    
	    $returnArray = array();
	    $sql = "SELECT * FROM tvusers WHERE username='" .$username. "'";
	    
	    $result = $this->conn->query($sql);
	    
	    if ($result != null && mysqli_num_rows($result) >= 1){
	        
	        $row = $result->fetch_array(MYSQLI_ASSOC);
	        
	        if (!empty($row)) {
	            $returnArray = $row;
	        }
	        
	    }
	    
	    return $returnArray;
	}
	
	// get only owner users
	public function getUserOwner($username) {
	    
	    $returnArray = array();
	    $sql = "SELECT * FROM tvusers WHERE username='" .$username. "' and role='Owner'";
	    
	    $result = $this->conn->query($sql);
	    
	    if ($result != null && mysqli_num_rows($result) >= 1){
	        
	        $row = $result->fetch_array(MYSQLI_ASSOC);
	        
	        if (!empty($row)) {
	            $returnArray = $row;
	        }
	        
	    }
	    
	    return $returnArray;
	}
	
	// **** ADDED EVENT INFO ****
	
	// Insert event details
	public function addEvent($eventname, $eventlocation, $eventdate, $fullname, $creator_username){
		
		// sql command
		$sql = "INSERT INTO tvevents SET eventname=?, eventlocation=?, eventdate=?, fullname=?, creator_username=?";
		
		// store sql result in statement
		$statement = $this->conn->prepare($sql);
		
		// if error
		if (!$statement){
			throw new Exception($statement->error);
		}
		
		// bind 5 parameters of type string to be placed in sql command
		$statement->bind_param("sssss", $eventname, $eventlocation, $eventdate, $fullname, $creator_username);
		
		$returnValue = $statement->execute();
		
		return $returnValue;
	}
	
	// select event information
	public function selectEvent($eventname){
		
		$sql = "SELECT * FROM tvevents WHERE eventname='" .$eventname. "'";
		
		// assign result from sql to result var
		$result = $this->conn->query($sql);
		
		// if there is at least one result returned
		if ($result != null && (mysqli_num_rows($result) >=1)){
			
			// assign results we got to $row as associatative array
			$row = $result->fetch_array(MYSQLI_ASSOC);
		
			if (!empty($row)) {
				$returnArray = $row;
			}
		}
		
		return $returnArray;
		
		
	}
	
	// select next event information
	public function selectNextEvent(){
		
		//$sql = "SELECT * FROM tvevents WHERE fullname='Fred Ford' ORDER BY eventdate LIMIT 1";
		$sql = "SELECT * FROM tvevents WHERE fullname='Fred Ford' and eventdate >= NOW() ORDER BY eventdate LIMIT 1";
		
		// assign result from sql to result var
		$result = $this->conn->query($sql);
		
		// if there is at least one result returned
		if ($result != null && (mysqli_num_rows($result) >=1)){
			
			// assign results we got to $row as associatative array
			$row = $result->fetch_array(MYSQLI_ASSOC);
		
			if (!empty($row)) {
				$returnArray = $row;
			}
		}
		
		return $returnArray;
		
		
	}
	
    // add additional info if you are a cargiver
	public function addCaregiverInfo($owner_fullname, $owner_username, $username){
		
		// sql command
		$sql = "INSERT INTO tvusers SET owner_fullname=?, owner_username=? WHERE username='" .$username. "'";
		
		// store sql result in statement
		$statement = $this->conn->prepare($sql);
		
		// if error
		if (!$statement){
			throw new Exception($statement->error);
		}
		
		// bind 5 parameters of type string to be placed in sql command
		$statement->bind_param("sss", $owner_fullname, $owner_username, $username);
		
		$returnValue = $statement->execute();
		
		return $returnValue;
	}
	
	// add event idea
		public function addEventIdea($idea){
		
		// sql command
		$sql = "INSERT INTO tveventideas SET username='fkjones', idea=?";
		
		// store sql result in statement
		$statement = $this->conn->prepare($sql);
		
		// if error
		if (!$statement){
			throw new Exception($statement->error);
		}
		
		// bind 5 parameters of type string to be placed in sql command
		$statement->bind_param("s", $idea);
		
		$returnValue = $statement->execute();
		
		return $returnValue;
	}
	
	// select all events made by the specific user
public function selectEvents($username){
    
    $returnArray = array();
	
	$sql = "SELECT 
	            id,
				eventname,
				eventlocation,
				eventdate
			FROM tvevents
			WHERE creator_username ='" .$username.
			"' ORDER BY eventdate";
			
		
	$statement = $this->conn->prepare($sql);
	
	if (!$statement){
		throw new Exception($statement->error);
	}
	
	
	$statement->execute();
	
	$result = $statement->get_result();
	
	
	while($row = $result->fetch_assoc()) {
		$returnArray[] = $row;
	}
	
	return $returnArray;
	
	
    }
    
    // add this function to the access.php file
    public function deleteEvent($id) {

	$sql = "DELETE FROM tvevents WHERE id = ?";
	$statement = $this->conn->prepare($sql);
	
	if (!$statement) {
		throw new Exception($statement->error);
	}
	
	$statement->bind_param("s", $id);
    $statement->execute();
	
	$returnValue = $statement->affected_rows;
	
	return $returnValue;
	
}

   // add this function to the access.php file
    public function deleteEventIdea($id) {

	$sql = "DELETE FROM tveventideas WHERE id = ?";
	$statement = $this->conn->prepare($sql);
	
	if (!$statement) {
		throw new Exception($statement->error);
	}
	
	$statement->bind_param("s", $id);
    $statement->execute();
	
	$returnValue = $statement->affected_rows;
	
	return $returnValue;
	
}

	// select all events ideas made by the specific user
public function selectIdeas($owner_username){
    
    $returnArray = array();
	
	$sql = "SELECT 
	            id,
				idea
			FROM tveventideas
			WHERE username ='" .$owner_username.
			"'";
			
		
	$statement = $this->conn->prepare($sql);
	
	if (!$statement){
		throw new Exception($statement->error);
	}
	
	
	$statement->execute();
	
	$result = $statement->get_result();
	
	
	while($row = $result->fetch_assoc()) {
		$returnArray[] = $row;
	}
	
	return $returnArray;
	
	
    }


}




?>
