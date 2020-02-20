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
# offline

#$db_location = "localhost";$db_username = "root";$db_passwort = "";$db_name = "tsc";

# bplaced

#$db_location = "localhost";$db_username = "syndicate";$db_passwort = "xG9001xg";$db_name = "syndicate";

# strato

$db_location='rdbms.strato.de';$db_username='U3924953';$db_passwort='!ah$d6m&H4#pY9R8s';$db_name='DB3924953';



/* Counter Start */

$con = mysqli_connect($db_location, $db_username, $db_passwort) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 
$ip = $_SERVER['REMOTE_ADDR']; // get ip
$test = mysqli_query($con, "SELECT * FROM thomasschilb WHERE ip='$ip'"); // test if ip is given
if(mysqli_num_rows($test) != 1) {
mysqli_query($con, "INSERT INTO thomasschilb SET ip='$ip'"); // else make db entry
}
$query = mysqli_query($con, "SELECT cid FROM thomasschilb");
$num_rows = mysqli_num_rows($query); // get entry rows to number
$overall_counter_state = $num_rows + 12183;
echo '<span class="counter"><center><font face="homespun_tt_brkregular">No.&nbsp;' . $overall_counter_state . '</font></center></span>';
mysqli_close($con);
 
/* Counter End */

?>
