<!DOCTYPE html>
<html>

<head>
<meta content="de" http-equiv="Content-Language">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<link rel="icon" type="image/png" href="favicon.png">
<link rel="icon" href="favicon.ico" type="image/x-icon">
<!-- <link rel="shortcut icon" href="http://x.bplaced.com/x/favicon.ico" type="image/x-icon"> -->
<meta name="author" content="Thomas Schilb">
<meta name="publisher" content="Thomas Schilb">
<meta name="copyright" content="© 2020 SCHILB.">
<meta content="schilb, private, intern" name="keywords">
<meta content="private homepage" name="description">
<meta name="robots" content="all, index, follow"> 
<meta name="googlebot" content="all, index, follow"> 
<meta name="pagerank" content="10"> 
<meta name="msnbot" content="all,index,follow"> 
<meta name="revisit" content="2 Days"> 
<meta name="revisit-after" content="2 Days"> 
<meta name="alexa" content="100">
<meta content="de" http-equiv="Content-Language">
<base target="_blank">
<link href="https://fonts.googleapis.com/css?family=Inter:300" rel="stylesheet">

<style type="text/css">
a {
	color: #808080;
	text-decoration: none;
}
a:visited {
	color: #808080;
}
a:active {
	color: #808080;
}
a:hover {
	-moz-transition: all .3s ease-in;
	-o-transition: all .3s ease-in;
	-webkit-transition: all .3s ease-in;
	transition: all .3s ease-in;
	color: #FFFFFF;
}
.font-family {
	font-family: 'Inter', sans-serif;
}
.font-title {
	font-family: 'Inter', sans-serif;
	font-size: 72pt;
	color: #808080;
	background-color: #C0C0C0;
}
.menu {
	font-family: 'Inter', sans-serif;
	background-color: #000000;
}
.copyright {
	font-family: 'Inter', sans-serif;
	text-align: center;
}
.counter {
	text-align: right;
	background-color: #333333;
	font-size: 15pt;
}
.menu-bg {
	background-color: #333333;
	font-size: 15pt;
}
.title-header {
	font-family: 'Inter', sans-serif;
	font-size: 72pt;
	color: #808080;
	background-color: #085089;
	background-image: url('img/schilb-background.jpg');
}
.border-null {
	border-width: 0px;
}
.font-15pt-center {
	font-family: 'Inter', sans-serif;
	text-align: center;
	background-color: #333333;
	font-size: 15pt;
}
.font-15pt-right {
	font-size: 15pt;
	text-align: right;
}
.color-fff {
	color: #FFFFFF;
}
.title-header {
	font-size: 31pt;
}
p {
				font-family: 'Inter', sans-serif;
	}
.title-footer {
	font-size: 15pt;
}
.footer-emptyspace {
	font-family: 'Inter', sans-serif;
	text-align: center;
	font-size: 15pt;
}
.header-bluebutton {
	background-color: #085089;
	color: #0B77CC;
}
</style>
</head>

<body style="color: #808080; margin: 0; background-color: #000000">

<table cellpadding="0" cellspacing="0" style="width: 100%">
	<tr>
		<td class="title-header">
		<table cellpadding="0" cellspacing="18" size="100%" style="width: 100%">
			<tr>
				<td style="width: 115px">&nbsp;</td>
				<td class="font-15pt-right" valign="top">
				&nbsp;</td>
			</tr>
			<tr>
				<td style="width: 115px"><font size="3">
				<a href="?to=start" target="_self"><img class="border-null" height="128" src="img/schilb-logo.png" width="134"></a></font></td>
				<td class="font-15pt-right" valign="top">
				&nbsp;</td>
			</tr>
		</table>
<!-- Logo Start -->
<!-- Logo End -->
		</td>
	</tr>
	<tr>
		<td class="menu">
		<table cellpadding="15" cellspacing="0" style="width: 100%">
			<tr>
				<td class="menu-bg">
				<table align="left" cellpadding="5" cellspacing="0">
					<tr>
						<td style="width: 14px" class="header-bluebutton">&Uuml;</td>
						<td><a href="?to=uberuns" target="_self">&Uuml;ber Uns</a></td>
						<td style="width: 15px">&nbsp;</td>
						<td style="width: 15px" class="header-bluebutton">M</td>
						<td> <span class="color-fff">
						<a href="?to=medien" target="_self">Medien</a></span></td>
						<td style="width: 15px">&nbsp;</td>
						<td style="width: 15px" class="header-bluebutton">I</td>
						<td>
				<a href="?to=info" target="_self">Info</a></td>
						<td style="width: 15px">&nbsp;</td>
						<td style="width: 15px" class="header-bluebutton">I</td>
						<td>
				<a href="?to=impressum" target="_self">Impressum</a></td>
						<td style="width: 15px">&nbsp;</td>
						<td style="width: 15px" class="header-bluebutton">K</td>
						<td>
				<a href="?to=kontakt" target="_self">Kontakt</a></td>
					</tr>
				</table>
				</td>
				<td class="counter"><?php include('counter.php'); ?></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="font-family">
		<table cellpadding="15" cellspacing="0" style="width: 100%">
			<tr>
			<td>
<?php
# get
$to = $_GET['to'];
# include given
if ($to == "start")       			{include("content/start.html");}
elseif ($to == "medien")  			{include("content/medien.html");}
elseif ($to == "kontakt")  			{include("content/kontakt.php");}
elseif ($to == "uberuns")  			{include("content/uberuns.html");}
elseif ($to == "impressum")  		{include("content/impressum.html");}
elseif ($to == "info")  				{include("content/info.html");}
# secure
	else {
include("content/start.html");
#else {echo '<meta target="_self" http-equiv="refresh" content="0; URL=/?to=login">';}
}
?>
			</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="font-15pt-center">		<table cellpadding="15" cellspacing="0" style="width: 100%">
			<tr>
				<td class="menu-bg">Copyright &copy; 2020 SCHILB. Alle Rechte 
				Vorbehalten.</td>
			</tr>
		</table>
</td>
	</tr>
	</table>

</body>

</html>