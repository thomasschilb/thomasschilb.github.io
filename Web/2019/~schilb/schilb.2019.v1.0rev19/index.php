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
<meta content="schilb, private, intern" name="keywords">
<meta content="family site, familien seite" name="description">
<meta name="robots" content="all, index, follow"> 
<meta name="googlebot" content="all, index, follow"> 
<meta name="pagerank" content="10"> 
<meta name="msnbot" content="all,index,follow"> 
<meta name="revisit" content="2 Days"> 
<meta name="revisit-after" content="2 Days"> 
<meta name="alexa" content="100">
<base target="_blank">
<title>Schilb.info</title>
<?php
# get
$to = $_GET['to'];
# include given
if ($to == "start")       			{include("start.php");}
elseif ($to == "bilder")  			{include("bilder.php");}
elseif ($to == "geburtstage")  	{include("geburtstage.php");}
elseif ($to == "kontakt")  			{include("kontakt.php");}
elseif ($to == "herkunft")  		{include("herkunft.php");}
elseif ($to == "newsticker")  	{include("newsticker.php");}
elseif ($to == "impressum")  		{include("impressum.php");}
elseif ($to == "info")  				{include("info.php");}
elseif ($to == "login")  				{include("member-login.php");}
elseif ($to == "in")
{
	$login = $_GET['login'];
	if ($login == "true")	{
			$section = $_GET['section'];
			if ($section == "member:start")									{include("member-start.php");}
			elseif ($section == "member:geburtstage")				{include("member-geburtstage.php");}
			elseif ($section == "member:internet")					{include("member-internet.php");}
			elseif ($section == "member:it-news")						{include("member-it-news.php");}
			elseif ($section == "member:medien")						{include("member-medien.php");}
			elseif ($section == "member:programmier-ecke")	{include("member-programmier-ecke.php");}
			elseif ($section == "member:logout")						{include("member-logout.php");}
			else {echo '<meta target="_self" http-equiv="refresh" content="0; URL=?to=login">';}
	}
	else {
#	$username = '$_POST[username]';$password = '$_POST[password]';
	if ($nosession_username = $_POST['username']=="schilb" && $_POST['password']=="NB7hedsgyZ36l3cmpOodK50LV8VlWi7G") {
	include("member-start.php");}
	else {
		echo '<meta target="_self" http-equiv="refresh" content="0; URL=?to=login">';
		}
#	session_start();
#		if ($_SESSION['login']==true || ($_POST['username']=="schilb" && $_POST['password']=="NB7hedsgyZ36l3cmpOodK50LV8VlWi7G"))
#			{include("member.php");$_SESSION['login']=true;}
				}
}
# secure
	else {
include("start.php");
#else {echo '<meta target="_self" http-equiv="refresh" content="0; URL=/?to=login">';}
}
?>

</head>
<body></body>
</html>