<?php

/* Connection Data */

# $db_location = "localhost";$db_username = "root";$db_passwort = "0001355";$db_name="tsc";
$db_location='rdbms.strato.de';$db_username='U3924953';$db_passwort='!ah$d6m&H4#pY9R8s';$db_name='DB3924953';

/* Select DB */

$con = mysqli_connect($db_location, $db_username, $db_passwort) or die ('OFFLINE'); 
mysqli_select_db($con, $db_name) or die ('DATABASE DOES NOT EXISTS'); 
#mysqli_close ( mysqli $con );

?>
