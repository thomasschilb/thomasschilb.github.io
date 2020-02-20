<?php

# 0.0

#$db_location = "localhost"; //Ort der Datenbank (normalerweise "localhost")
#$db_username = "syndicate"; //Benutzername für DB-Zugriff
#$db_passwort = "xG9001xg"; //Passwort für DB-Zugriff
#$db_name = "syndicate"; //Name der Datenbank

# 0.1

$db_location = "localhost"; //Ort der Datenbank (normalerweise "localhost")
$db_username = "root"; //Benutzername für DB-Zugriff
$db_passwort = ""; //Passwort für DB-Zugriff
$db_name = "tsc"; //Name der Datenbank

$con = mysqli_connect($db_location, $db_username, $db_passwort) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 
#mysqli_close ( mysqli $con );

?>
