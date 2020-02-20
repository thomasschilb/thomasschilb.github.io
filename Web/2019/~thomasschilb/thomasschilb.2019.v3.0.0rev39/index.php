<!DOCTYPE html>
<html>
<head>
<link rel="icon" 
      type="image/png" 
      href="favicon.png">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta name="author" content="Thomas Schilb">
<meta name="publisher" content="Thomas Schilb">
<meta name="copyright" content="(c)2015-2019">
<meta name="description" content="Code, Design, Music & More">
<meta name="keywords" content="code, css, dotnet, html, javascript, mysqli, php, qb64, visual basic, design, pictures, photshop, winamp, fonts, music, techno, industrial, minimal, electronic, hardstyle, mp3, zip, thomas, schilb, projects, knowledge, contact, scenemusic">
<meta name="page-topic" content="Thomas Schilb | TSC">
<meta name="page-type" content="Private Homepage">
<meta name="audience" content="all">
<meta name="robots" content="index, follow"> 
<meta name="googlebot" content="index, follow"> 
<meta name="pagerank" content="10"> 
<meta name="msnbot" content="none"> 
<meta name="revisit" content="2 Days"> 
<meta name="revisit-after" content="2 Days"> 
<meta name="alexa" content="100">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Thomas Schilb | TSC</title>
<style type="text/css">
@font-face {
font-family: 'homespun_tt_brkregular';
src: url('http://thomasschilb.tk/tsc-fonts-homespun.woff2') format('woff2'),
     url('http://thomasschilb.tk/tsc-fonts-homespun.woff') format('woff'),
     url('http://thomasschilb.tk/tsc-fonts-homespun.ttf') format('ttf'),
     url('http://thomasschilb.tk/tsc-fonts-homespun.eot') format('eot'),
     url('http://thomasschilb.tk/tsc-fonts-homespun.svg') format('svg');
font-weight: normal;
font-style: normal;
}
body {
background-image: url('img/tsc.jpg')
}
#graycol:hover {
-webkit-filter: grayscale(0%);
-webkit-transition: .5s ease-in-out;
-moz-filter: grayscale(0%);
-moz-transition: .5s ease-in-out;
-o-filter: grayscale(0%);
-o-transition: .5s ease-in-out;
}
#graycol {
-webkit-filter: grayscale(100%);
-webkit-transition: .5s ease-in-out;
-moz-filter: grayscale(100%);
-moz-transition: .5s ease-in-out;
-o-filter: grayscale(100%);
-o-transition: .5s ease-in-out;
}
a {
	color: #808080;
	text-decoration: none;
	-moz-transition: all .3s ease-in;
	-o-transition: all .3s ease-in;
	-webkit-transition: all .3s ease-in;
	transition: all .3s ease-in;
}
a:visited {
	color: #808080;
}
a:active {
	color: #808080;
}
a:hover {
	color: #31C8F9;
}
.text-align-center {
	text-align: center;
}
.table-border-1px-blue {
	border: 1px solid #31C8F9;
}
.background-color-blue {
	background-color: #31C8F9;
}
.table-1px-font-10pt {
	border: 1px solid #31C8F9;
	font-size: 10pt;
}
.font-family {
}
.font-12pt-color-31C8F9 {
	color: #31C8F9;
	font-size: 12pt;
}
.font-12pt-family {
	font-size: 12pt;
}
.font-12pt {
	font-size: 12pt;
}
.font-12pt-family-center {
	text-align: center;
	font-size: 12pt;
}
.font-12pt-border-0 {
	border-width: 0px;
	font-size: 12pt;
}
.auto-style9tsc {
	text-align: center;
	font-size: 12pt;
	color: #FFFFFF;
}
.auto-style10tsc {
	color: #31C8F9;
}
.auto-style102tsc {
	color: #FFFFFF;
}
.auto-style11tsc {
	color: #218AAC;
}
.auto-style12tsc {
	color: #18637B;
}
.auto-style13tsc {
	color: #218AAC;
	font-size: 12pt;
}
.auto-style14tsc {
	color: #18637B;
	font-size: 12pt;
}
</style>
<meta content="Code, Design, Music" name="keywords">
<meta content="Private Homepage" name="description">
<base target="_blank">
</head>
<font face="homespun_tt_brkregular">
<body style="color: #C0C0C0; margin: 0; background-color: #000000">

<?php
# get
$to = $_GET['to'];
# include given
if ($to == "welcome")      		{include("html/header.html");        include("html/welcome.html"); include("php/footer.php");}
elseif ($to == "code")     		{include("html/header-code.html");   include("html/code.html");    include("php/footer.php");}
elseif ($to == "design")   		{include("html/header-design.html"); include("html/design.html");  include("php/footer.php");}
elseif ($to == "music")    		{include("html/header-music.html");  include("html/music.html");   include("php/footer.php");}
elseif ($to == "legal")    		{include("html/header-legal.html");  include("html/legal.html");   include("php/footer.php");}
elseif ($to == "legal-gate")    {include("html/header-gate.html");   include("html/legal.html");   include("php/footer.php");}

elseif ($to == "aio")              {include("php/header-more.php"); include("html/aio.html");                include("php/footer.php");}
elseif ($to == "bannercodes")      {include("php/header-more.php"); include("html/bannercodes.html");        include("php/footer.php");}
elseif ($to == "contact")          {include("php/header-more.php"); include("php/contact.php");              include("php/footer.php");}
elseif ($to == "contact-complete") {include("php/header-more.php"); include("contact/contact-complete.php"); include("php/footer.php");}
elseif ($to == "donate")           {include("php/header-more.php"); include("html/donate.html");             include("php/footer.php");}
elseif ($to == "emulate")          {include("php/header-more.php"); include("html/emulate.html");            include("php/footer.php");}
elseif ($to == "games")            {include("php/header-more.php"); include("html/games.html");              include("php/footer.php");}
elseif ($to == "links")            {include("php/header-more.php"); include("html/links.html");              include("php/footer.php");}
elseif ($to == "modules")          {include("php/header-more.php"); include("html/modules.html");            include("php/footer.php");}
elseif ($to == "mymusic")          {include("php/header-more.php"); include("html/mymusic.html");            include("php/footer.php");}
elseif ($to == "projects")         {include("php/header-more.php"); include("html/projects.html");           include("php/footer.php");}
elseif ($to == "samples")          {include("php/header-more.php"); include("html/samples.html");            include("php/footer.php");}
elseif ($to == "scripts")          {include("php/header-more.php"); include("html/scripts.html");            include("php/footer.php");}
elseif ($to == "selfshots")        {include("php/header-more.php"); include("html/selfshots.html");          include("php/footer.php");}
elseif ($to == "share")            {include("php/header-more.php"); include("html/share.html");              include("php/footer.php");}
elseif ($to == "site")             {include("php/header-more.php"); include("html/site.html");               include("php/footer.php");}
elseif ($to == "snippets")         {include("php/header-more.php"); include("html/snippets.html");           include("php/footer.php");}
elseif ($to == "software")         {include("php/header-more.php"); include("html/software.html");           include("php/footer.php");}
elseif ($to == "tools")            {include("php/header-more.php"); include("html/tools.html");              include("php/footer.php");}
elseif ($to == "tutorials")        {include("php/header-more.php"); include("html/tutorials.html");          include("php/footer.php");}
elseif ($to == "xxx")              {include("php/header-more.php"); include("html/xxx.html");                include("php/footer.php");}

elseif ($to == "gate")     {include("php/in.php");}
elseif ($to == "!nfo")     {include("html/nfo.html");}
# secure
else {include("php/in.php");}
?>

<p>&nbsp;</p>
</font>
</body>
</html>
