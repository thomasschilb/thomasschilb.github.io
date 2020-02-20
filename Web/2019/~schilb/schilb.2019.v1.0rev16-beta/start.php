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
<meta content="private homepage" name="description">
<meta name="robots" content="all, index, follow"> 
<meta name="googlebot" content="all, index, follow"> 
<meta name="pagerank" content="10"> 
<meta name="msnbot" content="all,index,follow"> 
<meta name="revisit" content="2 Days"> 
<meta name="revisit-after" content="2 Days"> 
<meta name="alexa" content="100">
<base target="_blank">
<title>Schilb</title>
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
	font-family: Verdana, Geneva, Tahoma, sans-serif;
}
.font-title {
	font-family: Verdana, Geneva, Tahoma, sans-serif;
	font-size: 72pt;
	color: #808080;
	background-color: #C0C0C0;
}
.menu {
	font-family: Verdana, Geneva, Tahoma, sans-serif;
	background-color: #000000;
}
.copyright {
	font-family: Verdana, Geneva, Tahoma, sans-serif;
	text-align: center;
}
.counter {
	text-align: right;
	background-color: #333333;
}
.menu-bg {
	background-color: #333333;
}
.auto-style2 {
	color: #FFFFFF;
}
.auto-style3 {
	font-family: Verdana, Geneva, Tahoma, sans-serif;
	font-size: 72pt;
	color: #808080;
	background-color: #085089;
	background-image: url('img/schilb-title.jpg');
}
.border-null {
	border-width: 0px;
}
.auto-style4 {
	font-family: Verdana, Geneva, Tahoma, sans-serif;
	text-align: center;
	background-color: #333333;
}
.auto-style6 {
	font-size: 10pt;
	text-align: right;
}
.auto-style7 {
	font-size: 8pt;
}
.auto-style9 {
	color: #FFFFFF;
}
</style>
</head>

<body style="color: #808080; margin: 0; background-color: #000000">

<table cellpadding="0" cellspacing="0" style="width: 100%">
	<tr>
		<td class="auto-style3">
		<table cellpadding="0" cellspacing="18" size="100%" style="width: 100%">
			<tr>
				<td style="width: 115px"><font size="3">
				<a href="?to=start" target="_self"><img class="border-null" height="128" src="img/schilb-logo.png" width="134"></a></font></td>
				<td class="auto-style6" valign="top">
				<a href="?to=login" target="_self">Login</a></td>
			</tr>
		</table>
<!-- Logo Start -->
<!-- Logo End -->
		</td>
	</tr>
	<tr>
		<td class="menu">
		<table cellpadding="10" cellspacing="0" style="width: 100%">
			<tr>
				<td class="menu-bg"><a href="?to=herkunft" target="_self">
				Herkunft</a> | <span class="auto-style9">
				<a href="?to=bilder" target="_self">Bilder</a></span> |
				<a href="?to=kontakt" target="_self">Kontakt</a> |
				<a href="?to=info" target="_self">Info</a> |
				<a href="?to=impressum" target="_self">Impressum</a></td>
				<td class="counter"><?php include('counter.php'); ?></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="font-family">
		<table cellpadding="10" cellspacing="0" style="width: 100%">
			<tr>
				<td><br><span class="auto-style2">Willkommen!</span><br><br>
				Diese Seite ist Privatbesitz der Familie Schilb und deren 
				Angehörigen.<br>Die Nutzung ist ausschließlich für 
				Familienmitglieder und<br>deren Bekannte bestimmt. Bitte nicht in falsche Hände 
				geben.<br><br><br><em><span class="auto-style2">Neu:</span> 
				Logo, Info, Login<br><br><br></em><span class="auto-style7">
<?
		$getdomain = "$_SERVER[HTTP_HOST]";
		if ($getdomain == "schilb.info") {?><em><a target="_self" href="https://schilb.info">schilb.info</a> is powered by </em> </span><a href="https://www.strato.de/"><span class="auto-style7"><em>strato</em></a><?}
		elseif ($getdomain == "www.schilb.info"){?><em><a target="_self" href="https://www.schilb.info">www.schilb.info</a> is powered by <a href="https://www.strato.de/">strato</a></span></em><?}
		elseif ($getdomain == "schilb.info.tm"){?><em><a target="_self" href="http://schilb.info.tm">schilb.info.tm</a> is powered by <a href="https://www.bplaced.net/">bplaced</a>, <a href="https://freedns.afraid.org/">freedns</a></span></em><?}
		else {include "start.php";}
?>
				
				</span></a></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="copyright">&nbsp;</td>
	</tr>
	<tr>
		<td class="auto-style4">&nbsp;<br>Copyright &copy; 2019, 2020 
		SCHILB. Alle Rechte Vorbehalten.<br>&nbsp;</td>
	</tr>
	</table>

</body>

</html>
