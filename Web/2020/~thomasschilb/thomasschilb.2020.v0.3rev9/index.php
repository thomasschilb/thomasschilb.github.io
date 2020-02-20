<!DOCTYPE html>
<html>

<head>
<head>
<link rel="icon" 
      type="image/png" 
      href="favicon.png">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta name="author" content="Thomas Schilb">
<meta name="publisher" content="Thomas Schilb">
<meta name="copyright" content="(c)2015-2019">
<meta name=“robots“ content=“all“ />
<!--
<meta name="description" lang="de" content="Programmieren. Design. Music. & Mehr" />
<meta name="description" lang="en" content="Code. Design. Music. & More" />
-->
<meta name="description" content="Projects: Podcast, Web">
<meta name="keywords" content="code, css, dotnet, html, javascript, mysqli, php, qb64, visual basic, design, pictures, photshop, winamp, fonts, music, techno, industrial, minimal, electronic, hardstyle, mp3, zip, thomas, schilb, projects, knowledge, contact, scenemusic">
<meta name="page-topic" content="Thomas Schilb | TS">
<meta name="page-type" content="Private Homepage">
<meta name="audience" content="the audience is listening...">
<meta name="robots" content="index, follow"> 
<meta name="googlebot" content="index, follow"> 
<meta name="pagerank" content="10"> 
<meta name="msnbot" content="none"> 
<meta name="revisit" content="2 Days"> 
<meta name="revisit-after" content="2 Days"> 
<meta name="alexa" content="100">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Thomas Schilb | TS</title>
<style>

/* BODY */

body {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	}

/* HYPERLINKS */

a {
	color: #808080;
	text-decoration: none;
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

/* TABLE */

#tstable {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
}

#tstable td, #tstable th {
  border: 0px solid #333333;
  padding: 8px;
}

#tstable tr:nth-child(even){background-color: #202020;}

#tstable tr:hover {background-color: #444444;}

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
  background-color: #333;
}

li {
  float: left;
}

li a, .dropbtn {
  display: inline-block;
  color: #808080;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

li a:hover, .dropdown:hover .dropbtn {
  background-color: #444;
  color: #31C8F9;
}

li.dropdown {
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #444;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: #808080;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
}

.dropdown-content a:hover {background-color: #555;}

.dropdown:hover .dropdown-content {
  display: block;
}

.auto-style3 {
	border-width: 0px;
}

.auto-style4 {
	text-align: right;
}
.auto-style5 {
	text-align: left;
}

</style>
<base target="_blank">
</head>

<body style="margin: 0; color: #808080; background-color: #000000">

<table cellpadding="8" cellspacing="0" style="width: 100%">
	<tr>
		<td class="font-small" style="height: 25px">&nbsp;</td>
	</tr>
	<tr>
		<td class="font-small">&nbsp;<a target="_self" href="?to=welcome" target="_self"><img height="78" src="img/ts.png" width="161" class="auto-style3"></a></td>
	</tr>
	<tr>
		<td class="font-small" style="height: 25px">&nbsp;</td>
	</tr>
	</table>

<ul>
  <li class="dropdown">
    <a target="_self" href="javascript:void(0)" class="dropbtn">Projects</a>
    <div class="dropdown-content">
      <a target="_self" href="?to=projects:archive">Archive</a>
      <a target="_self" href="?to=projects:podcast">Podcast</a>
      <a target="_self" href="?to=projects:web">Web</a>
    </div>
  </li>

  <li><a target="_self" href="?to=contact">Contact</a></li>
  
  <li><a target="_self" href="?to=about">About</a></li>
  
  <li style="float:right"><a target="_self" href="?to=login">Login</a></li>

</ul>

<table cellpadding="25" cellspacing="0" style="width: 100%">
	<tr>
		<td>
		<?php
		# get
		$to = $_GET['to'];
		# include given
		if ($to == "welcome")      			{include("php/welcome.php");}
		elseif ($to == "projects:archive")  {include("php/projects-archive.php");}
		elseif ($to == "projects:podcast")  {include("php/projects-podcast.php");}
		elseif ($to == "projects:web")  	{include("php/projects-web.php");}
		elseif ($to == "contact")  			{include("php/contact.php");}
		elseif ($to == "about")   			{include("php/about.php");}
		elseif ($to == "login")   			{include("php/member-login.php");}
		elseif ($to == "tac")   			{include("php/tac.php");}
		elseif ($to == "privacy")  			{include("php/privacy.php");}
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
	include("php/member-start.php");}
	else {
		echo '<meta target="_self" http-equiv="refresh" content="0; URL=?to=login">';
		}
#	session_start();
#		if ($_SESSION['login']==true || ($_POST['username']=="schilb" && $_POST['password']=="NB7hedsgyZ36l3cmpOodK50LV8VlWi7G"))
#			{include("member.php");$_SESSION['login']=true;}
				}
}
		# secure
		else {include("php/welcome.php");}
		?>
	</td>
	</tr>
</table>
<table cellpadding="16" cellspacing="0" class="color-white" style="width: 100%">
	<tr>
		<td class="auto-style5"><font size="2">Copyright &copy; 2019, 2020 TS. All Rights Reserved.</font><br>
		</td>
		<td class="auto-style4">
		<a href="?to=tac" target="_self"><font size="2">Terms and Conditions</font></a><font size="2"> | 
		</font> 
		<a href="?to=privacy" target="_self"><font size="2">Privacy Policy</font></a></td>
	</tr>
</table>

</body>

</html>
