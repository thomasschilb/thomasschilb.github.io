<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.counter {
	color: #FFFFFF;
	font-family: "Courier New", Courier, monospace;
	font-size: 12pt;
}
</style>
</head>
<?php
# offline

$db_location = "localhost";$db_username = "root";$db_passwort = "";$db_name = "tsc";

# online

#$db_location = "localhost";$db_username = "syndicate";$db_passwort = "xG9001xg";$db_name = "syndicate";

# counter

$con = mysqli_connect($db_location, $db_username, $db_passwort) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 
$ip = $_SERVER['REMOTE_ADDR']; // get ip
$test = mysqli_query($con, "SELECT * FROM thomasschilb WHERE ip='$ip'"); // test if ip is given
if(mysqli_num_rows($test) != 1) {
mysqli_query($con, "INSERT INTO thomasschilb SET ip='$ip'"); // else make db entry
}
$count1 = mysqli_query($con, "SELECT cid FROM thomasschilb");
$count = mysqli_num_rows($count1); // get entry rows to number
echo '<span class="counter"><center><font class="counter">No.&nbsp;' . $count . '</font></center></span>';
mysqli_close($con); 

?>
