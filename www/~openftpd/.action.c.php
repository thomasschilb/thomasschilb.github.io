<?php

# openirc: Counter v0.1rev1


/* Connection Data */

$db_location = "127.0.0.1";$db_username = "thomasschilb";$db_passwort = "1234";$db_name="ts";

/* Select DB */

$con = mysqli_connect($db_location, $db_username, $db_passwort) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 

/* Get IP Adress */

$ip = $_SERVER['REMOTE_ADDR']; // get ip

/* Counter Routines */

$test = mysqli_query($con, "SELECT * FROM openftpd WHERE ip='$ip'"); // test if ip is given
	  if(mysqli_num_rows($test) != 1) {
      mysqli_query($con, "INSERT INTO openftpd SET ip='$ip'"); // else make db entry
      $count = mysqli_num_rows(mysqli_query($con, "SELECT cid FROM openftpd")); // get entry (rows to number)
      $allyearscount = $count;
			echo '' . $allyearscount . '';
      mysqli_close($con); 
	  }
	  
	  else {
      $count = mysqli_num_rows(mysqli_query($con, "SELECT cid FROM openftpd")); // get entry (rows to number)
      $allyearscount = $count + 100;
	  echo '' . $allyearscount . '';
	  mysqli_close($con); 
	  }

?>
