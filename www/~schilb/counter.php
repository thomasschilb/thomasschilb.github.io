<?php

/* Connection Data */

# server
$db_location = "127.0.0.1";$db_username = "thomasschilb";$db_passwort = "1234";$db_name = "ts";

/* Counter Output */

$con = mysqli_connect($db_location, $db_username, $db_passwort) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 

$ip = $_SERVER['REMOTE_ADDR']; // get ip
$test = mysqli_query($con, "SELECT * FROM `schilb-counter` WHERE ip='$ip'"); // test if ip is given
if(mysqli_num_rows($test) != 1) {
mysqli_query($con, "INSERT INTO `schilb-counter` SET ip='$ip'"); // else make db entry
}
$count1 = mysqli_query($con, "SELECT cid FROM `schilb-counter`");
$count = mysqli_num_rows($count1); // get entry rows to number
$allyearscount = $count + 7000;
echo 'No. '.$allyearscount.'';

mysqli_close($con);
?>
