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
	background-image: url('img/prescene-title.png');
	text-align: right;
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
}
.border-black {
	border: 2px solid #7B7B7B;
}
.font-10pt {
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
}
.font-10pt-gray {
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
	text-align: center;
}
a {
	text-decoration: none;
	color: #808080;
	-moz-transition: all .3s ease-in;
	-o-transition: all .3s ease-in;
	-webkit-transition: all .3s ease-in;
	transition: all .3s ease-in;

}
a:hover {
	font-weight: bold;
	color: #FFFFFF;
}
a:visited {
	color: #7B7B7B;
}
a:active {
	color: #7B7B7B;
}
</style>
</head>

<body style="color: #777777; background-color: #000000">
<!-- <p class="font-10pt">&nbsp;</p> -->
<?php
# get
$to = $_GET['to'];
# include given
if ($to == "welcome")          		{echo "<br>";include("php/header.php");include("php/welcome.php");include('php/footer.php');include('counter.php');}
elseif ($to == "web")  			    {echo "<br>";include("php/header.php");include("php/web.php");include('php/footer.php');include('counter.php');}
elseif ($to == "emule")      		{echo "<br>";include("php/header.php");include("php/emule.php");include('php/footer.php');include('counter.php');}
elseif ($to == "torrent")      		{echo "<br>";include("php/header.php");include("php/torrent.php");include('php/footer.php');include('counter.php');}
elseif ($to == "usenet")      		{echo "<br>";include("php/header.php");include("php/usenet.php");include('php/footer.php');include('counter.php');}
elseif ($to == "xdcc")   			{echo "<br>";include("php/header.php");include("php/xdcc.php");include('php/footer.php');include('counter.php');}
elseif ($to == "legal")   			{echo "<br>";include("php/header.php");include("php/legal.php");include('php/footer.php');include('counter.php');}
elseif ($to == "nfo")   			{echo "<br>";include("php/header.php");include("php/nfo.php");include('php/footer.php');include('counter.php');}
elseif ($to == "gate")   			{include("php/gate.php");}
elseif ($to == "gate-legal")   		{include("php/gate-legal.php");include('php/footer.php');include('counter.php');}
elseif ($to == "")                  {include("php/gate.php");}
# secure
else {include("php/gate.php");}
?>


</body>

</html>
