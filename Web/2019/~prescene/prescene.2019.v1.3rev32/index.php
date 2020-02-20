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
<meta name="description" content="BBS. FTP. EMULE. ONION. TORRENT. USENET. WEB. XDCC.">
<meta name="keywords" content="pre, prescene, share, sites, software, linklist, disclaimer, legal-disclosure, imprint, nocopy!, bbs, ftp, emule, client, mods, sites, serverlist, kad, torrent, torrents, magnet, dl, search, tracker, usenet, binaries, news, provider, dl, search, web, 0day-releases, zer0day, pre, search, dl, xdcc, bots, channels, network, packets, dl, search, onion, darknet, deepweb">
<meta name="robots" content="all, index, follow"> 
<meta name="googlebot" content="all, index, follow"> 
<meta name="pagerank" content="10"> 
<meta name="msnbot" content="all,index,follow"> 
<meta name="revisit" content="2 Days"> 
<meta name="revisit-after" content="2 Days"> 
<meta name="alexa" content="100">
<base target="_blank"><title>PRESCENE</title>
<script>
function bannercode_small() {
  /* Get the text field */
  var copyText = document.getElementById("bannercode_small");

  /* Select the text field */
  copyText.select();

  /* Copy the text inside the text field */
  document.execCommand("copy");

  /* Alert the copied text */
  /* alert("Successfully added to Clipboard!"); */
  alert('Successfully added the Code to Clipboard. Content: "' + copyText.value + '" Now copy & paste it to your Site!');
}
function bannercode_large() {
  /* Get the text field */
  var copyText = document.getElementById("bannercode_large");

  /* Select the text field */
  copyText.select();

  /* Copy the text inside the text field */
  document.execCommand("copy");

  /* Alert the copied text */  
  /* alert("Successfully added the Code to Clipboard! */
  alert('Successfully added the Code to Clipboard. Content: "' + copyText.value + '" Now copy & paste it to your Site!');
}
</script>

<style type="text/css">
a {
	text-decoration: none;
	color: #7B7B7B;
}
a:hover {
	font-weight: bold;
	color: #FFFFFF;
	-moz-transition: all .3s ease-in;
	-o-transition: all .3s ease-in;
	-webkit-transition: all .3s ease-in;
	transition: all .3s ease-in;
}
a:visited {
	color: #7B7B7B;
}
a:active {
	color: #7B7B7B;
}
#graycol:hover {-webkit-filter: grayscale(0%);-webkit-transition: .5s ease-in-out;-moz-filter: grayscale(0%);-moz-transition: .5s ease-in-out;-o-filter: grayscale(0%);-o-transition: .5s ease-in-out;}
#graycol {-webkit-filter: grayscale(100%);-webkit-transition: .5s ease-in-out;-moz-filter: grayscale(100%);-moz-transition: .5s ease-in-out;-o-filter: grayscale(100%);-o-transition: .5s ease-in-out;}
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
elseif ($to == "onion")      		{echo "<br>";include("php/onion.php");include('counter.php');}
elseif ($to == "torrent")      		{echo "<br>";include("php/torrent.php");include('counter.php');}
elseif ($to == "usenet")      		{echo "<br>";include("php/usenet.php");include('counter.php');}
elseif ($to == "xdcc")   			{echo "<br>";include("php/xdcc.php");include('counter.php');}
elseif ($to == "legal")   			{echo "<br>";include("php/legal.php");include('counter.php');}
elseif ($to == "site")   			{echo "<br>";include("php/site.php");include('counter.php');}
elseif ($to == "gate-legal")   		{echo "<br>";include("php/gate-legal.php");}
elseif ($to == "")                  {echo "<br>";include("php/gate-index.php");echo "<br><br>";}
elseif ($to == "view-all")          {echo "<br>";include("php/view-all/view-index.php");echo "<br><br>";}
elseif ($to == "view-single")       {echo "<br>";include("php/bbs.php");echo "<br><br>";}
# secure
else {echo "<br>";include("php/gate-index.php");echo "<br><br>";}
?>


</body>

</html>
