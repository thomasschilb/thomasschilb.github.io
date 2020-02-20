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
<meta name="description" content="0-Day, Torrent, Usenet, XDCC">
<meta name="keywords" content="0day, 0-day, zer0day, pre, sites, software, torrent, usenet, xdcc">
<meta name="robots" content="all, index, follow"> 
<meta name="googlebot" content="all, index, follow"> 
<meta name="pagerank" content="10"> 
<meta name="msnbot" content="all,index,follow"> 
<meta name="revisit" content="2 Days"> 
<meta name="revisit-after" content="2 Days"> 
<meta name="alexa" content="100">
<base target="_blank"><title>.prescene</title>
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
if ($to == "welcome")          		{include("html/welcome.html");}
elseif ($to == "0-day")  			{include("html/0-day.html");}
elseif ($to == "torrent")      		{include("html/torrent.html");}
elseif ($to == "usenet")      		{include("html/usenet.html");}
elseif ($to == "xdcc")   			{include("html/xdcc.html");}
elseif ($to == "legal")   			{include("html/legal.html");}
# secure
else {include("html/welcome.html");}
?>
<?php include('counter.php');?>

</body>

</html>
