<!DOCTYPE html>
<html>

<head>
<link rel="icon" 
      type="image/png" 
      href="favicon.png">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta content="de-de" http-equiv="Content-Language">
<title>Syndicate.CF | 2019</title>
<style type="text/css">
a {
	color: #FFFFFF;
	text-decoration: none;
	    -moz-transition: all .3s ease-in;
    -o-transition: all .3s ease-in;
    -webkit-transition: all .3s ease-in;
    transition: all .3s ease-in;
}
a:visited {
	color: #FFFFFF;
	text-decoration: none;
}
a:active {
	color: #FFFFFF;
	text-decoration: none;
}
a:hover {
	color: #FF0000;
	text-decoration: none;
}
</style>
<meta content="News, Links, Software, Games, Tutorials, Tools" name="description">
<base target="_blank">
</head>

<body style="color: #FFFFFF; margin: 0px; background-color: #000000; font-size: 2; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;">
<br><br>
<center><a target="_self" href="index.php"><img src="img/title.gif"></a></center>
<table align="center" cellpadding="0" cellspacing="0" style="width: 690px">
	<tr>
		<td style="text-align: center"><?php include("topmenu.de.plus.html");?></td>
	</tr>
		<tr>
		<td style="text-align: center">&nbsp;</td>
	</tr>
	<tr><td style="border: 1px solid #3F3F3F; text-align: left; ; background-image: url('img/tab-bg.gif')"><table cellpadding="10" cellspacing="0" style="width: 687px"><tr><td>
<!-- PHP Script Start -->
<?php

# Get category to show

$var = $_GET['kat'];

# If cat is given include site of category

if ($var > "") {
if ($var == "spiele") {include ("games.de.html");}
elseif ($var == "siteinfo") {include("siteinfo.de.php");}
elseif ($var == "liesmich") {include("liesmich.html");}
elseif ($var == "magnet") {include("s.magnet.de.html");}
elseif ($var == "tools") {include("tools.de.html");}
elseif ($var == "tutorials") {include("tutorials.de.html");}
elseif ($var == "") {include("news.de.php");}
elseif ($var > "") {include("news.de.php");}
}




# If category is not given load welcome site

else {
include("games.de.html");
}
?>
<!-- PHP Script End -->
				</td>
			</tr>
		</table>
							<tr>
		<td style="width: 690px; text-align: right">
		<span style="color: rgb(63, 63, 63); font-family: &quot;Trebuchet MS&quot;, &quot;Lucida Sans Unicode&quot;, &quot;Lucida Grande&quot;, &quot;Lucida Sans&quot;, Arial, sans-serif; font-size: x-small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: -webkit-center; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(0, 0, 0); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">
		<font color="#3f3f3f"></font><span>&nbsp;</span></span><a href="main.php?lang=de&&menu=2&&kat=siteinfo" style="color: #3f3f3f; text-decoration: none; font-size: 8pt;" target="_self">SITEINFO</a></td>
	</tr>
		</td>
	</tr>
	<tr>
<!--		<td style="color: #3F3F3F">© 2017 All Rights Reserved.</td> -->
	<td style="color: #3F3F3F">
		<center><strong>Copyright&nbsp;</strong>&copy; 2012-2019 <a target="_Self" style="color: #3F3F3F; a{color: #FF0000};text-decoration: none;" href="main.php?lang=de&&menu=2&&kat=liesmich">Alle Rechte vorbehalten.</a></span></center>
		</td>
	</tr>
		<tr>
		<td>&nbsp;</td>
	</tr>
		<tr>
		<td>&nbsp;</td>
	</tr>
		<tr>
		<td>&nbsp;</td>
	</tr>
</table>

</body>

</html>
