<!DOCTYPE html>
<html>

<head>
<meta content="de" http-equiv="Content-Language">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<link rel="icon" type="image/png" href="favicon.png">
<link rel="icon" type="image/x-icon" href="favicon.ico">
<meta name="author" content="Familie Schilb">
<meta name="publisher" content="Thomas Schilb">
<meta name="copyright" content="© 2020 SCHILB.">
<meta content="offiziell, familie, schilb, seite, private, intern, family" name="keywords">
<meta content="Offizielle Seite der Familie Schilb" name="description">
<meta name="robots" content="all, index, follow"> 
<meta name="googlebot" content="all, index, follow"> 
<meta name="pagerank" content="10"> 
<meta name="msnbot" content="all,index,follow"> 
<meta name="revisit" content="2 Days"> 
<meta name="revisit-after" content="2 Days"> 
<meta name="alexa" content="100">
<base target="_blank">
<title>Familie | Schilb</title>
<?php
# get
$to = $_GET['to'];
# include given
if ($to == "start")       			{include("content/start.php");}
elseif ($to == "bilder")  			{include("content/bilder.php");}
elseif ($to == "kontakt")  			{include("content/kontakt.php");}
elseif ($to == "uberuns")  			{include("content/uberuns.php");}
elseif ($to == "impressum")  		{include("content/impressum.php");}
elseif ($to == "info")  				{include("content/info.php");}
# secure
	else {
include("content/start.php");
#else {echo '<meta target="_self" http-equiv="refresh" content="0; URL=/?to=login">';}
}
?>

</head>
<body></body>
</html>