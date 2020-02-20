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
if ($to == "start")       			{include("start.php");}
elseif ($to == "bilder")  			{include("bilder.php");}
elseif ($to == "kontakt")  			{include("kontakt.php");}
elseif ($to == "uberuns")  			{include("uberuns.php");}
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
			elseif ($section == "user:bilder")							{include("user-bilder.php");}
			elseif ($section == "user:uberuns")							{include("user-uberuns.php");}
			elseif ($section == "user:info")								{include("user-info.php");}
			elseif ($section == "user:kontakt")							{include("user-kontakt.php");}
			elseif ($section == "user:impressum")						{include("user-impressum.php");}
				
			else {echo '<meta target="_self" http-equiv="refresh" content="0; URL=?to=login">';}
	}
	else {
#	$username = '$_POST[username]';$password = '$_POST[password]';
	if ($nosession_username = $_POST['username']=="familie.schilb.xyz" && $_POST['password']=="1984") {
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