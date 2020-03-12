<!-- Counter v0.1 (thomas.schilb@live.de)--> 
<html>
<head>
<link rel="icon" type="image/png" href="favicon.png">
<title>TS | Counter v0.1</title>
</head>
<?php

/* Connection Data */

$db_location = "localhost";
$db_username = "root";
$db_passwort = "";
$db_name = "tsc";

/* Counter Start */

$con = mysqli_connect($db_location, $db_username, $db_passwort) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 
$ip = $_SERVER['REMOTE_ADDR']; // get ip
$test = mysqli_query($con, "SELECT * FROM counter WHERE ip='$ip'"); // test if ip is given
if(mysqli_num_rows($test) != 1) {
mysqli_query($con, "INSERT INTO counter SET ip='$ip'"); // else make db entry
}
$query = mysqli_query($con, "SELECT cid FROM counter");
$num_rows = mysqli_num_rows($query); // get entry rows to number
$overall_counter_state = $num_rows + 1501;
echo '' . $overall_counter_state . '';
mysqli_close($con);
 
/* Counter End */

?>
</html>