<!DOCTYPE html>
<html>

<head>
<meta content="de" http-equiv="Content-Language">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<!-- <link rel="icon" 
      type="image/png" 
      href="favicon.png"> -->
<link rel="icon" href="favicon.ico" type="image/x-icon">
<!-- <link rel="shortcut icon" href="http://x.bplaced.com/x/favicon.ico" type="image/x-icon"> -->
<meta name="author" content="Thomas Schilb">
<meta name="publisher" content="Thomas Schilb">
<meta name="copyright" content="© 2019 SCHILB.">
<meta content="family, familie, schilb, privat, private, intern" name="keywords">
<meta content="private homepage" name="description">
<meta name="robots" content="all, index, follow"> 
<meta name="googlebot" content="all, index, follow"> 
<meta name="pagerank" content="10"> 
<meta name="msnbot" content="all,index,follow"> 
<meta name="revisit" content="2 Days"> 
<meta name="revisit-after" content="2 Days"> 
<meta name="alexa" content="100">
<base target="_blank">
<title>Schilb | .info</title>
</head>
<?php
# get
$to = $_GET['to'];
# include given
if ($to == "start")       			{include("start.php");}
elseif ($to == "bilder")  			{include("bilder.php");}
elseif ($to == "geburtstage")  	{include("geburtstage.php");}
elseif ($to == "emails")  			{include("emails.php");}
elseif ($to == "herkunft")  		{include("herkunft.php");}
elseif ($to == "newsticker")  	{include("newsticker.php");}
elseif ($to == "disclaimer")  	{include("disclaimer.php");}
elseif ($to == "info")  				{include("info.php");}
elseif ($to == "login")  				{include("login.php");}
# secure
else {include("start.php");}
?>