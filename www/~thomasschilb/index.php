<?php
$getdomain = "$_SERVER[HTTP_HOST]";
if ($getdomain == "thomasschilb.de") {include "de/index.php";}
elseif ($getdomain == "www.thomasschilb.de") {include "de/index.php";}
else {include "en/index.php";}
?>