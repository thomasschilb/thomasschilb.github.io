<!DOCTYPE html>
<html>

<head>
<link rel="icon" 
      type="image/png" 
      href="favicon.png">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta content="de-de" http-equiv="Content-Language">
<title>The Digital Syndicate | TDS</title>
<style type="text/css">
a {
	color: #FFFFFF;
	text-decoration: none;
	    -moz-transition: all .3s ease-in;
    -o-transition: all .3s ease-in;
    -webkit-transition: all .3s ease-in;
    transition: all .3s ease-in;
}
a:visited {
	color: #FFFFFF;
	text-decoration: none;
}
a:active {
	color: #FFFFFF;
	text-decoration: none;
}
a:hover {
	color: #FF0000;
	text-decoration: none;
}
</style>
<meta content="News, Links, Software, Games, Tutorials, Tools" name="description">
<base target="_blank">
</head>

<body style="color: #FFFFFF; margin: 0px; background-color: #000000; font-size: 2; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;">
<br><br>
<center><img src="img/title.gif"></center>
<table align="center" cellpadding="0" cellspacing="0" style="width: 690px">
	<tr>
		<td style="text-align: center">&nbsp;</td>
	</tr>
	<tr>
		<td style="text-align: center"><?php include("topmenu.de.html");?></td>
	</tr>
		<tr>
		<td style="text-align: center">&nbsp;</td>
	</tr>
	<tr><td style="border: 1px solid #3F3F3F; text-align: left; ; background-image: url('img/tab-bg.gif')"><table cellpadding="10" cellspacing="0" style="width: 687px"><tr><td>
<!-- PHP Script Start -->
<?php

# Get category to show

$var = $_GET['kat'];

# If cat is given include site of category

if ($var > "") {
if ($var == "news") {include ("news.de.php");}
#Software
elseif ($var == "software") {
	include "software-de/s.de.windows.menu.html";
	$svar = $_GET['skat'];
	if ($svar == "audio") {
	include("software-de/s.de.audio.html");include("software-de/s.total.de.html");
	}
	elseif ($svar == "burn") {include("software-de/s.de.burn.html");include("software-de/s.total.de.html");}
	elseif ($svar == "chat") {include("software-de/s.de.chat.html");include("software-de/s.total.de.html");}
	elseif ($svar == "code") {include("software-de/s.de.code.html");include("software-de/s.total.de.html");}
	elseif ($svar == "corporate") {include("software-de/s.de.corporate.html");include("software-de/s.total.de.html");}
	elseif ($svar == "design") {include("software-de/s.de.design.html");include("software-de/s.total.de.html");}
	elseif ($svar == "editor") {include("software-de/s.de.editor.html");include("software-de/s.total.de.html");}
	elseif ($svar == "emulate") {include("software-de/s.de.emulate.html");include("software-de/s.total.de.html");}
	elseif ($svar == "ftp") {include("software-de/s.de.ftp.html");include("software-de/s.total.de.html");}
	elseif ($svar == "office") {include("software-de/s.de.office.html");include("software-de/s.total.de.html");}
	elseif ($svar == "os") {include("software-de/s.de.os.html");include("software-de/s.total.de.html");}
	elseif ($svar == "misc") {include("software-de/s.de.misc.html");include("software-de/s.total.de.html");}
	elseif ($svar == "packer") {include("software-de/s.de.packer.html");include("software-de/s.total.de.html");}
	elseif ($svar == "portable") {include("software-de/s.de.portable.html");include("software-de/s.total.de.html");}
	elseif ($svar == "recovery") {include("software-de/s.de.recovery.html");include("software-de/s.total.de.html");}
	elseif ($svar == "security") {include("software-de/s.de.security.html");include("software-de/s.total.de.html");}
	elseif ($svar == "sourcecode") {include("software-de/s.de.sourcecode.html");include("software-de/s.total.de.html");}
	elseif ($svar == "system") {include("software-de/s.de.system.html");include("software-de/s.total.de.html");}
	elseif ($svar == "tv") {include("software-de/s.de.tv.html");include("software-de/s.total.de.html");}
	elseif ($svar == "video") {include("software-de/s.de.video.html");include("software-de/s.total.de.html");}
	elseif ($svar == "alle") {include("software-de/view.php");include("software-de/s.total.de.html");}
	elseif ($svar == "magnet") {include("s.magnet.de.html");}
	
    elseif ($svar > "") {include("software-de/s.de.audio.html");include("software-de/s.total.de.html");}
    else {
	include("software-de/s.de.audio.html");include("software-de/s.total.de.html");}
	}	

#Links
elseif ($var == "links") {
	echo '<b><font size="8" color="#414141">Links</font></b>';
	include "links/l.kat.html";
	$lvar = $_GET['lkat'];
	if ($lvar == "audio") {
	include("links/l.audio.html");include("links/l.total.de.html");
	}
	elseif ($lvar == "code") {include("links/l.code.html");include("links/l.total.de.html");}
	elseif ($lvar == "design") {include("links/l.design.html");include("links/l.total.de.html");}
    elseif ($lvar == "develope") {include("links/l.develope.html");include("links/l.total.de.html");}
    elseif ($lvar == "document") {include("links/l.document.html");include("links/l.total.de.html");}
    elseif ($lvar == "emulate") {include("links/l.emulate.html");include("links/l.total.de.html");}
    elseif ($lvar == "erotic") {include("links/l.erotic.html");include("links/l.total.de.html");}
    elseif ($lvar == "ftp") {include("links/l.ftp.html");include("links/l.total.de.html");}
	elseif ($lvar == "games") {include("links/l.games.html");include("links/l.total.de.html");}
	elseif ($lvar == "intern") {include("links/l.intern.html");include("links/l.total.de.html");}
    elseif ($lvar == "irc") {include("links/l.irc.html");include("links/l.total.de.html");}
    elseif ($lvar == "link") {include("links/l.link.html");include("links/l.total.de.html");}
    elseif ($lvar == "music") {include("links/l.music.html");include("links/l.total.de.html");}
    elseif ($lvar == "os") {include("links/l.os.html");include("links/l.total.de.html");}
    elseif ($lvar == "portable") {include("links/l.portable.html");include("links/l.total.de.html");}
    elseif ($lvar == "scene") {include("links/l.scene.html");include("links/l.total.de.html");}
    elseif ($lvar == "security") {include("links/l.security.html");include("links/l.total.de.html");}
    elseif ($lvar == "share") {include("links/l.share.html");include("links/l.total.de.html");}
    elseif ($lvar == "storage") {include("links/l.storage.html");include("links/l.total.de.html");}
    elseif ($lvar == "torrent") {include("links/l.torrent.html");include("links/l.total.de.html");}
    elseif ($lvar == "tv") {include("links/l.tv.html");include("links/l.total.de.html");}
    elseif ($lvar == "unlock") {include("links/l.unlock.html");include("links/l.total.de.html");}
    elseif ($lvar == "webmaster") {include("links/l.webmaster.html");include("links/l.total.de.html");}
    elseif ($lvar == "xdcc") {include("links/l.xdcc.html");include("links/l.total.de.html");}
    elseif ($lvar == "alle") {include("links/view.php");include("links/l.total.de.html");}
    else {
	include("links/l.audio.html");include("links/l.total.de.html");}
	}
#elseif ($var == "software") {include("software.html");}
elseif ($var == "siteinfo") {include("siteinfo.de.php");}
elseif ($var == "mehr") {include("mehr.html");}
elseif ($var == "liesmich") {include("liesmich.html");}
elseif ($var == "forum") {include("forum.php");}
elseif ($var == "spiele") {include("games.de.html");}
elseif ($var == "tools") {include("tools.de.html");}
elseif ($var == "tutorials") {include("tutorials.de.html");}

# Subcategories

# forum
elseif ($var == "since_forum_forumpost") {include("since_forum_forumpost.php");}
elseif ($var == "since_forum_replies") {include("since_forum_replies.php");}
elseif ($var == "since_forum_topics") {include("since_forum_topics.php");}


elseif ($var == "") {include("news.de.php");}
elseif ($var > "") {include("news.de.php");}
}

# If category is not given load welcome site

else {
include("news.de.php");
}
?>
<!-- PHP Script End -->
				</td>
			</tr>
		</table>
							<tr>
		<td style="width: 690px; text-align: right">
		<span style="color: rgb(63, 63, 63); font-family: &quot;Trebuchet MS&quot;, &quot;Lucida Sans Unicode&quot;, &quot;Lucida Grande&quot;, &quot;Lucida Sans&quot;, Arial, sans-serif; font-size: x-small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: -webkit-center; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(0, 0, 0); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">
		<font color="#3f3f3f"></font><span>&nbsp;</span></span><a href="main.php?lang=de&&menu=1&&kat=siteinfo" style="color: #3f3f3f; text-decoration: none; font-size: 8pt;" target="_self">SITEINFO</a></td>
	</tr>
		</td>
	</tr>
	<tr>
<!--		<td style="color: #3F3F3F">© 2017 All Rights Reserved.</td> -->
	<td style="color: #3F3F3F">
		<center><strong>Copyright&nbsp;</strong>&copy; 2012-2020 <a target="_Self" style="color: #3F3F3F; a{color: #FF0000};text-decoration: none;" href="main.php?lang=de&&menu=1&&kat=liesmich">Alle Rechte vorbehalten.</a></span></center>
		</td>
	</tr>
		<tr>
		<td>&nbsp;</td>
	</tr>

		<tr>
		<td>&nbsp;</td>
	</tr>

		<tr>
		<td>&nbsp;</td>
	</tr>

</table>

</body>

</html>
