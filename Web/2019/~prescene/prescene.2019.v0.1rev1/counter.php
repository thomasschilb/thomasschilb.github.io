<?php

$db_location = "localhost"; //Ort der Datenbank (normalerweise "localhost")
$db_username = "root"; //Benutzername für DB-Zugriff
$db_passwort = ""; //Passwort für DB-Zugriff
$db_name = "tsc"; //Name der Datenbank

# 0.2

$con = mysqli_connect($db_location, $db_username, $db_passwort) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 

$ip = $_SERVER['REMOTE_ADDR']; // get ip
$test = mysqli_query($con, "SELECT * FROM presource WHERE ip='$ip'"); // test if ip is given
if(mysqli_num_rows($test) != 1) {
mysqli_query($con, "INSERT INTO presource SET ip='$ip'"); // else make db entry
}
$count1 = mysqli_query($con, "SELECT cid FROM presource");
$count = mysqli_num_rows($count1); // get entry rows to number
echo '<center><font face="Courier, Monospace" color="#000000" size="2">No. '.$count.'</font></center>';
echo '<p class="font-10pt">&nbsp;</p>';
mysqli_close($con);
?>
