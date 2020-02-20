<?php

# connection

$db_location = "localhost"; //Ort der Datenbank (normalerweise "localhost")
$db_username = "root"; //Benutzername für DB-Zugriff
$db_passwort = ""; //Passwort für DB-Zugriff
$db_name = "tsc"; //Name der Datenbank

#$db_location = "localhost"; //Ort der Datenbank (normalerweise "localhost")
#$db_username = "prescene"; //Benutzername für DB-Zugriff
#$db_passwort = "!xg9000xg"; //Passwort für DB-Zugriff
#$db_name = "prescene"; //Name der Datenbank

# counter

$con = mysqli_connect($db_location, $db_username, $db_passwort) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 

$ip = $_SERVER['REMOTE_ADDR']; // get ip
$test = mysqli_query($con, "SELECT * FROM prescene WHERE ip='$ip'"); // test if ip is given
if(mysqli_num_rows($test) != 1) {
mysqli_query($con, "INSERT INTO prescene SET ip='$ip'"); // else make db entry
}
$count1 = mysqli_query($con, "SELECT cid FROM prescene");
$count = mysqli_num_rows($count1); // get entry rows to number
#echo '<center><font face="Courier, Monospace" color="#4F4F4F" size="2">No. '.$count.'</font></center>';
echo '<center><font face="Courier, Monospace" color="#800000" size="2">No. '.$count.'</font></center>';
echo '<br>';
mysqli_close($con);
?>
