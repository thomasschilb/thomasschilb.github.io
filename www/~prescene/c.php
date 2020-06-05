<?php

/* Connection Data */

#$db_location='rdbms.strato.de';$db_username='U3924953';$db_passwort='!ah$d6m&H4#pY9R8s';$db_name='DB3924953';
#$db_location = "127.0.0.1";$db_username = "thomasschilb";$db_password = "1234";$db_name = "ts";
$db_location = "localhost";$db_username = "scene-listings";$db_password = "1234";$db_name = "scene-listings_counter";


/* Open Connection */

$con = mysqli_connect($db_location, $db_username, $db_password) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 

/* Get Remote IP */

$ip = $_SERVER['REMOTE_ADDR'];

/* Query DB */

$test = mysqli_query($con, "SELECT * FROM `prescene` WHERE ip='$ip'"); // test, if ip is already given
if(mysqli_num_rows($test) != 1) {mysqli_query($con, "INSERT INTO `prescene` SET ip='$ip'");} // else, make db entry
$count1 = mysqli_query($con, "SELECT cid FROM `prescene`"); // select, all ids in db
$count = mysqli_num_rows($count1); // count, all ips in db

/* Counter Output */

$alltheyears = $count; // add counter state, exists before truncate the db
echo $alltheyears;

/* Close Connection */

mysqli_close($con);
?>
