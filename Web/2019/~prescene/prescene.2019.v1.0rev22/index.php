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
<base target="_blank"><title>PRESCENE</title>
<style type="text/css">
a {
	text-decoration: none;
	color: #7B7B7B;


}
a:hover {
	font-weight: bold;
	color: #FFFFFF;
	-moz-transition: all .5s ease-in;
	-o-transition: all .5s ease-in;
	-webkit-transition: all .5s ease-in;
	transition: all .5s ease-in;
}
a:visited {
	color: #7B7B7B;
}
a:active {
	color: #7B7B7B;
}
</style>
</head>

<body style="background-color: #000000">
<!-- <p class="font-10pt">&nbsp;</p> -->
<?php
# get
$to = $_GET['to'];
# include given
if ($to == "welcome")          		{echo "<br>";include("php/welcome.php");echo "<br>";include('counter.php');}
elseif ($to == "web")  			    {echo "<br>";include("php/web.php");include('counter.php');}
elseif ($to == "ftp")  			    {echo "<br>";include("php/ftp.php");include('counter.php');}
elseif ($to == "bbs")  			    {echo "<br>";include("php/bbs.php");include('counter.php');}
elseif ($to == "emule")      		{echo "<br>";include("php/emule.php");include('counter.php');}
elseif ($to == "torrent")      		{echo "<br>";include("php/torrent.php");include('counter.php');}
elseif ($to == "usenet")      		{echo "<br>";include("php/usenet.php");include('counter.php');}
elseif ($to == "xdcc")   			{echo "<br>";include("php/xdcc.php");include('counter.php');}
elseif ($to == "legal")   			{echo "<br>";include("php/legal.php");include('counter.php');}
elseif ($to == "site")   			{echo "<br>";include("php/site.php");include('counter.php');}
elseif ($to == "")                  {echo "<br>";include("php/welcome.php");echo "<br>";include('counter.php');}
# secure
else {echo "<br>";include("php/welcome.php");echo "<br>";include('counter.php');}
?>


</body>

</html>