<?php

/* Connection Data */

# Online
$db_location = "localhost";$db_username = "prescene";$db_passwort = "!xg9000xg";$db_name = "prescene";

# Offline
#$db_location = "localhost";$db_username = "root";$db_passwort = "";$db_name = "tsc";

/* Counter Output */

$con = mysqli_connect($db_location, $db_username, $db_passwort) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 

$ip = $_SERVER['REMOTE_ADDR']; // get ip
$test = mysqli_query($con, "SELECT * FROM schilb WHERE ip='$ip'"); // test if ip is given
if(mysqli_num_rows($test) != 1) {
mysqli_query($con, "INSERT INTO schilb SET ip='$ip'"); // else make db entry
}
$count1 = mysqli_query($con, "SELECT cid FROM schilb");
$count = mysqli_num_rows($count1); // get entry rows to number
#echo '<center><font face="Courier, Monospace" color="#7B7B7B" size="2">No. '.$count.'</font></center>';
echo 'No. '.$count.'';

mysqli_close($con);
?>