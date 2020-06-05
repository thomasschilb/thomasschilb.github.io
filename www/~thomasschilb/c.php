<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.counter {
	color: #FFFFFF;
	font-size: 12pt;
}
</style>
</head>
<?php

#$db_location = "127.0.0.1";$db_username = "thomasschilb";$db_password = "1234";$db_name = "ts";
#$db_location = "localhost";$db_username = "scene-listings_mariadb";$db_password = "1234";$db_name = "scene-listings_mariadb";
$db_location = "localhost";$db_username = "scene-listings";$db_password = "1234";$db_name = "scene-listings_counter";

/* Counter Start */

$con = mysqli_connect($db_location, $db_username, $db_password) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 
$ip = $_SERVER['REMOTE_ADDR']; // get ip
$test = mysqli_query($con, "SELECT * FROM `thomasschilb` WHERE ip='$ip'"); // test if ip is given
if(mysqli_num_rows($test) != 1) {
mysqli_query($con, "INSERT INTO `thomasschilb` SET ip='$ip'"); // else make db entry
}
$query = mysqli_query($con, "SELECT cid FROM `thomasschilb`");
$num_rows = mysqli_num_rows($query); // get entry rows to number
$overall_counter_state = $num_rows + 1;


/* Output */

echo $overall_counter_state;
mysqli_close($con);
 
/* Counter End */

?>
