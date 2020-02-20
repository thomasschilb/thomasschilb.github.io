<?php

# offline

$db_location = "localhost";$db_username = "root";$db_passwort = "";$db_name = "tsc";

# online
#$db_location = "localhost";$db_username = "pos";$db_passwort = "0001355";$db_name = "pos";

# 0.2

$con = mysqli_connect($db_location, $db_username, $db_passwort) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 

# 0.3

$ip = $_SERVER['REMOTE_ADDR']; // get ip
$test = mysqli_query($con, "SELECT * FROM kkc WHERE ip='$ip'"); // test if ip is given
if(mysqli_num_rows($test) != 1) {
mysqli_query($con, "INSERT INTO kkc SET ip='$ip'"); // else make db entry
}
$count1 = mysqli_query($con, "SELECT cid FROM kkc");
$count = mysqli_num_rows($count1); // get entry rows to number
$allyearscount = $count + 42;
echo '<font color="#808080">No. '.$allyearscount.'</font>';
mysqli_close($con);
?>
