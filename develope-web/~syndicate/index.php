<!DOCTYPE html>
<html>

<head>
<head>
<link rel="icon" type="image/png" href="favicon.png">
<link rel="icon" type="image/x-icon" href="favicon.ico">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta name="author" content="Thomas S.">
<meta name="publisher" content="Thomas S.">
<meta name="copyright" content="(c)2012-2020">
<meta name=“robots“ content=“all“ />
<!--
<meta name="description" lang="de" content="" />
<meta name="description" lang="en" content="" />
-->
<meta name="description" content="Official: IT-News & Links / Unofficial: Games, Software, TDS-Releases, Tools, Tutorials, FTP & IRC">
<meta name="keywords" content="news, links, games, software, tools, tutorials, ftp, irc">
<meta name="page-topic" content="Digital Syndicate | TDS">
<meta name="page-type" content="Private Homepage">
<meta name="audience" content="the audience is listening...">
<meta name="robots" content="index, follow"> 
<meta name="googlebot" content="index, follow"> 
<meta name="pagerank" content="10"> 
<meta name="msnbot" content="none"> 
<meta name="revisit" content="2 Days"> 
<meta name="revisit-after" content="2 Days"> 
<meta name="alexa" content="100">
<meta name="viewport" content="width=device-width, height=device-height">
<link href="https://fonts.googleapis.com/css?family=Share+Tech+Mono" rel="stylesheet"><style>

/* BODY */

body {
			font-family: 'Share Tech Mono';
			margin: 0;
			color: #808080;
			background-color: #000000
}

font {
				font-family: 'Share Tech Mono';
				font-size: 11pt;
	}

/* HYPERLINKS */

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
	color: #FF0000;
	-moz-transition: all .3s ease-in;
    -o-transition: all .3s ease-in;
    -webkit-transition: all .3s ease-in;
    transition: all .3s ease-in;
}

/* HYPERLINKS: GRAY PICTURES */

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

/* TABLE : PRIVACY */

#tstable-privacy {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
}

#tstable-privacy td, #tstable-privacy th {
  border: 0px solid #333333;
  padding: 8px;
}

#tstable-privacy tr:nth-child(odd){background-color: #101010;}

#tstable-privacy tr:nth-child(even){	    -moz-transition: all .3s ease-in;
    -o-transition: all .3s ease-in;
    -webkit-transition: all .3s ease-in;
    transition: all .3s ease-in;background-color: #202020;}

#tstable-privacy tr:hover {}

#tstable-privacy th {
  padding-top: 12px;
  padding-bottom: 12px;
  background-color: #333333;
  color: white;
}

/* TABLE : WEBCHAT */

#tstable-login {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
}

#tstable-login td, #tstable-login th {
  border: 0px solid #333333;
  padding: 8px;
}
#tstable-login tr:nth-child(odd){background-color: #101010;}
#tstable-login tr:nth-child(even){background-color: #202020;}

#tstable-login tr:hover {}

#tstable-login th {
  padding-top: 12px;
  padding-bottom: 12px;
/*  text-align: left; */
  background-color: #333333;
  color: white;
}

/* TABLE */

#tstable {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
}

#tstable td, #tstable th {
  border: 0px solid #333333;
  padding: 8px;
}

#tstable tr:nth-child(odd){background-color: #101010;}

#tstable tr:nth-child(even){background-color: #202020;}

#tstable tr:hover {color: #FFF; background-color: #222222;}

#tstable th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #333333;
  color: white;
}

/* FONT, MISC */

.font-normal {
	font-weight: normal;
}

.color-white {
	background-color: #333333;
}
.font-small {
	text-align: center;
}

/* NAVIGATION BAR */

ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-image:url('img/bar-header.png');
}

li {
  float: left;
}

li a, .dropbtn {
  display: inline-block;
  color: #808080;
  text-align: center;
  padding: 13px 15px;
  text-decoration: none;
}

li a:hover, .dropdown:hover .dropbtn {
  color: #FF0000;
}

li.dropdown {
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #333;
  min-width: 160px;
  z-index: 1;
}

.dropdown-content a {
  color: #808080;
  padding: 11px 15px;
  text-decoration: none;
  display: block;
  text-align: left;
}

.dropdown-content a:hover {}

.dropdown:hover .dropdown-content {
  display: block;
}

.border-width-null {
	border-width: 0px;
}
.bar-footer {
	text-align: right;
	background-image: url('img/bar-footer.png');
}
.bar-footer-right {
	text-align: right;
	background-image: url('img/bar-footer.png');
}
.bar-footer-left {
	text-align: left;
	background-image: url('img/bar-footer.png');
}

.font-12pt {
	font-size: 11pt;
}
.font-12pt-boder-null {
	border-width: 0px;
	font-size: 11pt;
}

.text-align-left {
	text-align: left;
}

</style>
<base target="_blank">
</head>

<body>
<font>
<table cellpadding="8" cellspacing="0" style="width: 100%">
	<tr>
		<td class="font-small" style="height: 35px"></td>
	</tr>
	<tr>
		<td class="font-small"><font size="3">&nbsp;</font><a target="_self" href="?to=welcome" target="_self"><img src="img/syndicate-title.png" class="font-12pt-boder-null"></a></td>
	</tr>
	<tr>
		<td class="font-small" style="height: 23px"></td>
	</tr>
	</table>

<ul>
  <li class="dropdown">
    <a target="_self" href="javascript:void(0)" class="dropbtn">Official</a>
    <div class="dropdown-content">
      <a target="_self" href="?to=syndicate:news">News</a>
      <a target="_self" href="?to=syndicate:links">Links</a>
    </div>
  </li>
  
    <li class="dropdown">
    <a target="_self" href="javascript:void(0)" class="dropbtn">Unofficial</a>
    <div class="dropdown-content">
      <a target="_self" href="?to=syndicate:games">Games</a>
      <a target="_self" href="?to=syndicate:software">Software</a>
      <a target="_self" href="?to=syndicate:tools">Tools</a>
      <a target="_self" href="?to=syndicate:tutorials">Tutorials</a>
      _______________________________
      <a target="_self" href="?to=syndicate:releases">TDS-Releases</a>
    </div>
  </li>

    <li class="dropdown">
    <a target="_self" href="javascript:void(0)" class="dropbtn">Service</a>
    <div class="dropdown-content">
		<a target="_self" href="?to=syndicate:ftp">FTP</a>
		<a target="_self" href="?to=syndicate:irc">IRC</a>
    </div>
  </li>
  
  <li><a href="?to=syndicate:vote" target="_self">Vote</a></li>
  
  <li style="float:right"><a target="_self" href="?to=syndicate:aboutus">About Us</a></li>


<!--  <li style="float:right"><a href="?to=syndicate:login" target="_self">Login</a></li> -->

</ul>

<table cellpadding="25" cellspacing="0" style="width: 100%">
	<tr>
		<td style="background-image: url('img/tab-bg.gif');">
		<?php
		# get
		$to = $_GET['to'];
		# include given
		if ($to == "welcome")      										{include("content/welcome.php");}
		
		elseif ($to == "syndicate:api:whatsapp")  							{include("content/api.whatsapp.php");}

		elseif ($to == "syndicate:irc")  							{include("content/irc.php");}
		elseif ($to == "syndicate:ftp")  							{include("content/ftp.php");}
		elseif ($to == "syndicate:vote")  						{include("content/vote.php");}
		elseif ($to == "syndicate:news")  						{include("content/news.php");/*include("content/ycombinator.php");*/}
		elseif ($to == "syndicate:games")  						{include("content/games.php");}
		elseif ($to == "syndicate:tools")  						{include("content/tools.php");}
		elseif ($to == "syndicate:tutorials")  				{include("content/tutorials.php");}
		elseif ($to == "syndicate:tc")  							{include("content/tc.php");}
		elseif ($to == "syndicate:pp")  							{include("content/pp.php");}
		elseif ($to == "syndicate:links")							{include("content/links.php");}
		elseif ($to == "syndicate:releases")						{include("content/releases.php");}
		elseif ($to == "syndicate:software")					{include("content/software.php");}
		elseif ($to == "syndicate:aboutus")  					{include("content/aboutus.php");}
    # links:category
		elseif ($to == "syndicate:links:audio")				{include("content/links.php");include("content/links/l.audio.html");}
		elseif ($to == "syndicate:links:code")				{include("content/links.php");include("content/links/l.code.html");}
		elseif ($to == "syndicate:links:design")			{include("content/links.php");include("content/links/l.design.html");}
		elseif ($to == "syndicate:links:develope")		{include("content/links.php");include("content/links/l.develope.html");}
		elseif ($to == "syndicate:links:document")		{include("content/links.php");include("content/links/l.document.html");}
		elseif ($to == "syndicate:links:emulate")			{include("content/links.php");include("content/links/l.emulate.html");}
		elseif ($to == "syndicate:links:erotic")			{include("content/links.php");include("content/links/l.erotic.html");}
		elseif ($to == "syndicate:links:ftp")					{include("content/links.php");include("content/links/l.ftp.html");}
		elseif ($to == "syndicate:links:games")				{include("content/links.php");include("content/links/l.games.html");}
		elseif ($to == "syndicate:links:intern")			{include("content/links.php");include("content/links/l.intern.html");}
		elseif ($to == "syndicate:links:irc")					{include("content/links.php");include("content/links/l.irc.html");}
		elseif ($to == "syndicate:links:link")				{include("content/links.php");include("content/links/l.link.html");}
		elseif ($to == "syndicate:links:music")				{include("content/links.php");include("content/links/l.music.html");}
		elseif ($to == "syndicate:links:os")					{include("content/links.php");include("content/links/l.os.html");}
		elseif ($to == "syndicate:links:portable")		{include("content/links.php");include("content/links/l.portable.html");}
		elseif ($to == "syndicate:links:scene")				{include("content/links.php");include("content/links/l.scene.html");}
		elseif ($to == "syndicate:links:security")		{include("content/links.php");include("content/links/l.security.html");}
		elseif ($to == "syndicate:links:share")				{include("content/links.php");include("content/links/l.share.html");}
		elseif ($to == "syndicate:links:storage")			{include("content/links.php");include("content/links/l.storage.html");}
		elseif ($to == "syndicate:links:torrent")			{include("content/links.php");include("content/links/l.torrent.html");}
		elseif ($to == "syndicate:links:tv")					{include("content/links.php");include("content/links/l.tv.html");}
		elseif ($to == "syndicate:links:unlock")			{include("content/links.php");include("content/links/l.unlock.html");}
		elseif ($to == "syndicate:links:webmaster")		{include("content/links.php");include("content/links/l.webmaster.html");}
		elseif ($to == "syndicate:links:xdcc")				{include("content/links.php");include("content/links/l.xdcc.html");}
	  #links:view
		elseif ($to == "syndicate:links:view-all")		{include("content/links.php");include("content/links/view.php");}
    # software:category
		elseif ($to == "syndicate:software:audio")						{include("content/software.php");include("content/software/s.audio.html");}
		elseif ($to == "syndicate:software:burn")							{include("content/software.php");include("content/software/s.burn.html");}
		elseif ($to == "syndicate:software:chat")							{include("content/software.php");include("content/software/s.chat.html");}
		elseif ($to == "syndicate:software:code")							{include("content/software.php");include("content/software/s.code.html");}
		elseif ($to == "syndicate:software:corporate")				{include("content/software.php");include("content/software/s.corporate.html");}
		elseif ($to == "syndicate:software:design")						{include("content/software.php");include("content/software/s.design.html");}
		elseif ($to == "syndicate:software:editor")						{include("content/software.php");include("content/software/s.editor.html");}
		elseif ($to == "syndicate:software:emulate")					{include("content/software.php");include("content/software/s.emulate.html");}
		elseif ($to == "syndicate:software:ftp")							{include("content/software.php");include("content/software/s.ftp.html");}
		elseif ($to == "syndicate:software:miscellaneous")		{include("content/software.php");include("content/software/s.miscellaneous.html");}
		elseif ($to == "syndicate:software:office")						{include("content/software.php");include("content/software/s.office.html");}
		elseif ($to == "syndicate:software:os")								{include("content/software.php");include("content/software/s.os.html");}
		elseif ($to == "syndicate:software:packer")						{include("content/software.php");include("content/software/s.packer.html");}
		elseif ($to == "syndicate:software:portable")					{include("content/software.php");include("content/software/s.portable.html");}
		elseif ($to == "syndicate:software:recovery")					{include("content/software.php");include("content/software/s.recovery.html");}
		elseif ($to == "syndicate:software:security")					{include("content/software.php");include("content/software/s.security.html");}
		elseif ($to == "syndicate:software:sourcecode")				{include("content/software.php");include("content/software/s.sourcecode.html");}
		elseif ($to == "syndicate:software:system")						{include("content/software.php");include("content/software/s.system.html");}
		elseif ($to == "syndicate:software:tv")								{include("content/software.php");include("content/software/s.tv.html");}
		elseif ($to == "syndicate:software:video")						{include("content/software.php");include("content/software/s.video.html");}
    #software:view
		elseif ($to == "syndicate:software:view-all")					{include("content/software.php");include("content/software/view.php");}
/*
elseif ($to == "in")
{
	$login = $_GET['login'];
	if ($login == "true")	{
			$section = $_GET['section'];
			if ($section == "member:start")									{include("member-start.php");}
			elseif ($section == "member:links")							{include("member-links.php");}
			elseif ($section == "member:logout")						{include("member-logout.php");}
			else {echo '<meta target="_self" http-equiv="refresh" content="0; URL=?to=login">';}
	}
	else {
#	$username = '$_POST[username]';$password = '$_POST[password]';
	if ($nosession_username = $_POST['username']=="tsc" && $_POST['password']=="0001355") {
	include("content/member-start.php");}
	else {
		echo '<meta target="_self" http-equiv="refresh" content="0; URL=?to=login">';
		}
#	session_start();
#		if ($_SESSION['login']==true || ($_POST['username']=="schilb" && $_POST['password']=="NB7hedsgyZ36l3cmpOodK50LV8VlWi7G"))
#			{include("member.php");$_SESSION['login']=true;}
				}
}
 */
		# secure
		else {include("content/welcome.php");}
		?>
	</td>
	</tr>
</table>
<table cellpadding="13" cellspacing="0" class="bar-footer" style="width: 100%">
	<tr>
		<td class="text-align-left">Copyright © 2012-2020 TDS. All Rights Reserved.</td>
		<td>
		<a href="?to=syndicate:tc" target="_self">Terms and Conditions</a> | <a href="?to=syndicate:pp" target="_self">Privacy Policy</a></td>
	</tr>
</table>
</font>
</body>

</html>
