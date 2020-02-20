<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta content="en-us" http-equiv="Content-Language">
<!-- <link rel="icon" 
      type="image/png" 
      href="favicon.png"> -->
<link rel="icon" href="favicon.ico" type="image/x-icon">
<!-- <link rel="shortcut icon" href="http://scenebb.bplaced.com/scenemusic/favicon.ico" type="image/x-icon"> -->
<meta name="author" content="Thomas Schilb">
<meta name="publisher" content="Thomas Schilb">
<meta name="copyright" content="© 2019 PRESCENE.">
<meta name="description" content="Emule, Torrent, Usenet, Web, XDCC">
<meta name="keywords" content="pre, prescene, share, sites, software, linklist, disclaimer, legal-disclosure, imprint, nocopy!, emule, client, mods, sites, serverlist, kad, torrent, torrents, magnet, dl, search, tracker, usenet, binaries, news, provider, dl, search, web, 0day-releases, zer0day, pre, search, dl, xdcc, bots, channels, network, packets, dl, search">
<meta name="robots" content="all, index, follow"> 
<meta name="googlebot" content="all, index, follow"> 
<meta name="pagerank" content="10"> 
<meta name="msnbot" content="all,index,follow"> 
<meta name="revisit" content="2 Days"> 
<meta name="revisit-after" content="2 Days"> 
<meta name="alexa" content="100">
<base target="_blank"><title>PRESCENE | 2019</title>
<style type="text/css">
.prescene-title {
	background-image: url('img/prescene.png');
	text-align: right;
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
}
.border-black {
	border: 1px solid #000000;
}
.font-10pt {
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
}
.font-10pt-gray {
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
	text-align: center;
	color: #808080;
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
	color: #000000;
}
</style>
</head>

<body>
<!-- <p class="font-10pt">&nbsp;</p> -->
<?php
# get
$to = $_GET['to'];
# include given
if ($to == "welcome")          		{include("html/welcome.html");include('counter.php');}
elseif ($to == "web")  			    {include("html/web.html");include('counter.php');}
elseif ($to == "emule")      		{include("html/emule.html");include('counter.php');}
elseif ($to == "torrent")      		{include("html/torrent.html");include('counter.php');}
elseif ($to == "usenet")      		{include("html/usenet.html");include('counter.php');}
elseif ($to == "xdcc")   			{include("html/xdcc.html");include('counter.php');}
elseif ($to == "legal")   			{include("html/legal.html");include('counter.php');}
elseif ($to == "site")   			{include("html/site.html");include('counter.php');}
elseif ($to == "gate")   			{include("php/gate.php");}
elseif ($to == "")                  {include("php/gate.php");}
# secure
else {include("php/gate.php");}
?>


</body>

</html>
