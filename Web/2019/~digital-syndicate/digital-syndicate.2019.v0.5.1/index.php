<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta content="en-us" http-equiv="Content-Language">
<meta content="de-de" http-equiv="Content-Language">
<title>Digital Syndicate | TDS</title>
<!-- <link rel="icon" 
      type="image/png" 
      href="favicon.png">
-->
<link rel="icon" href="favicon.ico" type="image/x-icon">
<base target="_self">
<meta name="author" content="Thomas S.">
<meta name="publisher" content="Thomas S.">
<meta name="developer" content="Thomas S.">
<meta name="copyright" content="(c)2012-2020">
<meta name="keywords" content="the-digital-syndicate, syndicate, digital, news, links, software, games, tools, tuturials, scene">
<meta name="page-topic" content="Digital Syndicate | TDS">
<meta name="page-type" content="Private Homepage">
<meta name="audience" content="all">
<meta name="robots" content="index, follow"> 
<meta name="googlebot" content="index, follow"> 
<meta name="pagerank" content="10"> 
<meta name="msnbot" content="index,follow"> 
<meta name="revisit" content="2 Days"> 
<meta name="revisit-after" content="2 Days"> 
<meta name="alexa" content="100">
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body style="color: #FFFFFF; margin: 0px; background-color: #000000; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;">
<?php
# access through domain
$getdomain = "$_SERVER[HTTP_HOST]";
if ($getdomain == "digital-syndicate.net") {
					# get
					$to = $_GET['to'];
					# include given
					if ($to == "gate") {
					# get
					$lang = $_GET['lang'];
					# include given
					if ($lang == "en")           {include("in.en.php");}
					elseif ($lang == "de")       {include("in.de.php");}
					# secure
					else {include("in.en.php");}
				   }
				   else {include("in.en.php");}
	}
elseif ($getdomain == "syndicate.cf"){
					# get
					$to = $_GET['to'];
					# include given
					if ($to == "gate") {
					# get
					$lang = $_GET['lang'];
					# include given
					if ($lang == "en")           {include("in.en.php");}
					elseif ($lang == "de")       {include("in.de.php");}
					# secure
					else {include("in.en.php");}
				   }
				   else {include("in.en.php");}
	}
elseif ($getdomain == "the-digital-syndicate.cf"){
					# get
					$to = $_GET['to'];
					# include given
					if ($to == "gate") {
					# get
					$lang = $_GET['lang'];
					# include given
					if ($lang == "en")           {include("in.en.php");}
					elseif ($lang == "de")       {include("in.de.php");}
					# secure
					else {include("in.en.php");}
				   }
				   else {include("in.en.php");}
	}
else {
		# get
					$to = $_GET['to'];
					# include given
					if ($to == "gate") {
					# get
					$lang = $_GET['lang'];
					# include given
					if ($lang == "en")           {include("in.en.php");}
					elseif ($lang == "de")       {include("in.de.php");}
					# secure
					else {include("in.en.php");}
				   }
				   else {include("in.en.php");}
	}
	



?>
</body>
</html>
