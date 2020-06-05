<?php

/* Connection Data */

#$db_location = "localhost";$db_username = "scene-listings";$db_password = "1234";$db_name = "scene-listings_counter";
$db_location = "fdb19.biz.nf";$db_username = "3455493_counter";$db_password = "xg9000xg";$db_name = "3455493_counter";

/* Counter Output */

$con = mysqli_connect($db_location, $db_username, $db_password) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 

$ip = $_SERVER['REMOTE_ADDR']; // get ip
$test = mysqli_query($con, "SELECT * FROM `schilb` WHERE ip='$ip'"); // test if ip is given
if(mysqli_num_rows($test) != 1) {
mysqli_query($con, "INSERT INTO `schilb` SET ip='$ip'"); // else make db entry
}
$count1 = mysqli_query($con, "SELECT cid FROM `schilb`");
$count = mysqli_num_rows($count1); // get entry rows to number
$allyearscount = $count + 8000;
echo 'Nr. '.$allyearscount.'';

mysqli_close($con);
?>
