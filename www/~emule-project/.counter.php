<?php

# offline

$db_location = "127.0.0.1";$db_username = "thomasschilb";$db_password = "1234";$db_name = "ts";

# 0.2

$con = mysqli_connect($db_location, $db_username, $db_password) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 

# 0.3

$ip = $_SERVER['REMOTE_ADDR']; // get ip
$test = mysqli_query($con, "SELECT * FROM `ep-counter` WHERE ip='$ip'"); // test if ip is given
if(mysqli_num_rows($test) != 1) {
mysqli_query($con, "INSERT INTO `ep-counter` SET ip='$ip'"); // else make db entry
}
$count1 = mysqli_query($con, "SELECT cid FROM `ep-counter`");
$count = mysqli_num_rows($count1); // get entry rows to number
$allyearscount = $count + 1;
#echo ''.$allyearscount.'';
echo $allyearscount;
mysqli_close($con);
?>
