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

$db_location = "localhost";$db_username = "root";$db_passwort = "";$db_name = "tsc";

# bplaced
#$db_location = "localhost";$db_username = "thomasschilb_counter";$db_passwort = "BEhmz45Q7iI8wK1eAX5hob3BB3eKyFa8";$db_name = "thomasschilb_counter";

# strato

#$db_location='rdbms.strato.de';$db_username='U3924953';$db_passwort='!ah$d6m&H4#pY9R8s';$db_name='DB3924953';

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
$overall_counter_state = $num_rows + 1501;


/* Output */

/*
    if(! function_exists('str_split'))
    {
        function str_split($overall_counter_state, $split = 1)
        {
            $array = array();
           
            for ($i = 0; $i < strlen($overall_counter_state);)
            {
                $array[] = substr($overall_counter_state, $i, $split);
                $i += $split;
            }
           
            return $array;
        }
    }
echo $array;
*/
#echo implode(' ', $overall_counter_state);
echo '' . $overall_counter_state . '';
mysqli_close($con);
 
/* Counter End */

?>
