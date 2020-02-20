<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta content="en-us" http-equiv="Content-Language">
<title>Syndicate.CF | 2019</title>
<link rel="icon" 
      type="image/png" 
      href="favicon.png">
<base target="_self">
<meta name="author" content="Thomas Schilb">
<meta name="publisher" content="Thomas Schilb">
<meta name="copyright" content="(c)2012-2019">
<meta name="description" content="Syndicate | 2019">
<meta name="robots" content="all, index, follow"> 
<meta name="googlebot" content="all, index, follow"> 
<meta name="pagerank" content="10"> 
<meta name="msnbot" content="all,index,follow"> 
<meta name="revisit" content="2 Days"> 
<meta name="revisit-after" content="2 Days"> 
<meta name="alexa" content="100">
<meta content="News, Links, Software, Games, Tools, Tutorials" name="description">
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body style="color: #FFFFFF; margin: 0px; background-color: #000000; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;">

<?php
$lang = $_GET['lang'];
if ($lang > "") {

### ENGLISH
if ($lang == "en") {
# start: select menu-en
$menu_en = $_GET['menu'];
if ($menu_en > "") {
if ($menu_en == "1") {include ("site.en.php");}
elseif ($menu_en == "2") {include("site.en.plus.php");}
}
else {
include("site.en.php");
}
# end: select menu-en
}

### GERMAN
elseif ($lang == "de") {
# start: select menu-de
	$menu_de = $_GET['menu'];
if ($menu_de > "") {
if ($menu_de == "1") {include ("site.de.php");}
elseif ($menu_de == "2") {include("site.de.plus.php");}
}
else {
include("site.de.php");
}
# end: select menu-de
}

else {
include("site.en.php");
}

}
?>
