<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta content="en-us" http-equiv="Content-Language">
<link rel="icon" 
      type="image/png" 
      href="favicon.png">
      <base target="_blank">
<meta name="author" content="POS">
<meta name="publisher" content="POS">
<meta name="copyright" content="Copyright (c) 2019 POS. All Rights Reversed.">
<meta name="description" content="Golem, Heise, Ycombinator -News">
<meta name="keywords" content="Golem, Heise, Ycombinator, News, IT-News">
<meta name="robots" content="all, index, follow"> 
<meta name="googlebot" content="all, index, follow"> 
<meta name="pagerank" content="10"> 
<meta name="msnbot" content="all,index,follow"> 
<meta name="revisit" content="2 Days"> 
<meta name="revisit-after" content="2 Days"> 
<meta name="alexa" content="100">
<base target="_blank">
<title>SYNDIKAT | NEWS</title>
<style type="text/css">
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
	color: #FFFFFF;
}
.table-border-null {
	border-color: #000000;
	border-width: 0;
}
.table-title {
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
	background-image: url('pos-title-info.png');
}
.font-monospace {
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
}
.color-white {
	color: #FFFFFF;
}
.table-menu-header {
	border-color: #333333;
	border-width: 0;
	background-color: #333333;
}
.text-header-right {
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
	text-align: right;
}
a {
	color: #808080;
}
a:visited {
	color: #808080;
}
a:active {
	color: #808080;
}
a:hover {
	color: #FFFFFF;
}
.text-deco-none {
	text-decoration: none;
}
.footer-text-center {
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
	text-align: center;
}
.footer-text-center2 {
	font-family: "Courier New", Courier, monospace;
}
.text-align-left-0 {
	text-align: left;
}
.text-align-left {
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
	text-align: left;
}
.nydus-center {
	text-align: center;
}
.auto-style1 {
	border-color: #333333;
	border-width: 0;
}
</style>
</head>

<body style="margin: 0; color: #808080; background-color: #000000">

<div class="text-align-left-0">

<table cellpadding="3" cellspacing="0" class="table-menu-header" style="width: 100%">
	<tr>
		<td class="text-align-left">
		<a href="http://syndikat.000webhostapp.com" target="_self">SCHILB-NEWS</a>://
		<a href="?to=golem" target="_self">.Golem</a> //
		<a class="text-deco-none" href="?to=heise" target="_self">.Heise</a> //
		<a href="?to=ycombinator" target="_self">.Ycombinator</a> //
		<a href="?to=info" target="_self">.Info</a> //&gt;</td>
		<td class="text-header-right">No. 
		<?php
	  include 'counter.php'; // connect db
	  $ip = $_SERVER['REMOTE_ADDR']; // get ip
	  $test = mysqli_query($con, "SELECT * FROM counter WHERE ip='$ip'"); // test if ip is given
	  if(mysqli_num_rows($test) != 1) {
      mysqli_query($con, "INSERT INTO counter SET ip='$ip'"); // else make db entry
#	  include ('new-ip.html'); // if ip is not given, include site
      $count = mysqli_num_rows(mysqli_query($con, "SELECT cid FROM counter")); // get entry (rows to number)
	  echo ''.$count.'';
      mysqli_close($con); 
	  }
	  
	  else {
      $count = mysqli_num_rows(mysqli_query($con, "SELECT cid FROM counter")); // get entry (rows to number)
	  echo ''.$count.'';
	  mysqli_close($con); 
	  }
	  ?>
		</td>
	</tr>
</table>
	<div class="nydus-center">
		&nbsp;	</div>
		<table align="center" cellspacing="0" class="auto-style1" style="width: 688px">
			<tr>
				<td>
				<font class="font-monospace"><?php
# get
$to = $_GET['to'];
# include given
if ($to == "info")          {include("info.html");}
elseif ($to == "golem")  {include("golem.html");}
elseif ($to == "heise")      {include("sidebar1.html");}
elseif ($to == "ycombinator")   {include("ycombinator.html");}
# secure
else {include("info.html");}
?></font>
				</td>
			</tr>
		</table>

	<center><span class="footer-text-center2"><font size="2"><br>Copyright &copy; 2019
	SCHILB.</font></span>
<span class="font-monospace"> <a href="?to=info" target="_self">All Rights Reversed.</a></span><br><br></center>
	<div class="nydus-center">
		<br>
	</div>
</div>
<p>&nbsp;</p>
</body>

</html>
