<?php

# openirc: Counter v0.1rev1


/* Connection Data */

$db_location = "localhost";$db_username = "root";$db_passwort = "";$db_name="tsc";

/* Select DB */

$con = mysqli_connect($db_location, $db_username, $db_passwort) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 

/* Get IP Adress */

$ip = $_SERVER['REMOTE_ADDR']; // get ip

/* Counter Routines */

$test = mysqli_query($con, "SELECT * FROM openirc WHERE ip='$ip'"); // test if ip is given
	  if(mysqli_num_rows($test) != 1) {
      mysqli_query($con, "INSERT INTO openirc SET ip='$ip'"); // else make db entry
      $count = mysqli_num_rows(mysqli_query($con, "SELECT cid FROM openirc")); // get entry (rows to number)
      $allyearscount = $count;
			echo '' . $allyearscount . '';
      mysqli_close($con); 
	  }
	  
	  else {
      $count = mysqli_num_rows(mysqli_query($con, "SELECT cid FROM openirc")); // get entry (rows to number)
      $allyearscount = $count + 200;
	  echo '' . $allyearscount . '';
	  mysqli_close($con); 
	  }

?>
