<?php

$getdomain = "$_SERVER[HTTP_HOST]";
if ($getdomain == "thomasschilb.de") {
	include "de/index.php";
	}
else {include "en/index.php";}

#$domain = $_SERVER['REMOTE_ADDR'];
#if ($domain = "thomasschilb.de" {include ('de/index.php');}
#else {include ('en/index.php');}
#echo $_SERVER['REMOTE_ADDR'];
?>