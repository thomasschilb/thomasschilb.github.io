<!DOCTYPE html>
<html>

<head>
<link rel="icon" 
      type="image/png" 
      href="favicon.png">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta content="en-us" http-equiv="Content-Language">
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
.auto-style1 {
	border-width: 0px;
}
</style>
<meta content="News, Links, Software, Games, Tutorials, Tools" name="description">
<base target="_blank">
</head>

<body style="color: #FFFFFF; margin: 0px; background-color: #000000; font-size: 2; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;">
<br><br>
<center>
<a href="http://www.digital-syndicate.net" target="_self" title="Link Us!">
<img src="img/title.gif" class="auto-style1"></a></center>
<table align="center" cellpadding="0" cellspacing="0" style="width: 690px">
	<tr>
		<td style="text-align: center">&nbsp;</td>
	</tr>
	<tr>
		<td style="text-align: center"><?php include("topmenu.en.html");?></td>
	</tr>
		<tr>
		<td style="text-align: center">&nbsp;</td>
	</tr>
	<tr><td style="border: 1px solid #3F3F3F; text-align: left; ; background-image: url('img/tab-bg.gif')"><table cellpadding="10" cellspacing="0" style="width: 687px"><tr><td>
<!-- PHP Script Start -->
<?php

# Get category to show

$var = $_GET['cat'];

# If cat is given include site of category

if ($var > "") {
if ($var == "news") {include ("news.en.php");}
#Software

elseif ($var == "software") {
	include "software-en/s.en.windows.menu.html";
	$svar = $_GET['scat'];
	if ($svar == "audio") {echo '<font color="#FF0000"><span style="font-size: x-large">&nbsp;<br></span></font>';
	include("software-en/s.en.audio.html");include("software-en/s.total.en.html");
	}
	elseif ($svar == "burn") {include("software-en/s.en.burn.html");include("software-en/s.total.en.html");}
	elseif ($svar == "chat") {include("software-en/s.en.chat.html");include("software-en/s.total.en.html");}
	elseif ($svar == "code") {include("software-en/s.en.code.html");include("software-en/s.total.en.html");}
	elseif ($svar == "corporate") {include("software-en/s.en.corporate.html");include("software-en/s.total.en.html");}
	elseif ($svar == "design") {include("software-en/s.en.design.html");include("software-en/s.total.en.html");}
	elseif ($svar == "editor") {include("software-en/s.en.editor.html");include("software-en/s.total.en.html");}
	elseif ($svar == "emulate") {include("software-en/s.en.emulate.html");include("software-en/s.total.en.html");}
	elseif ($svar == "ftp") {include("software-en/s.en.ftp.html");include("software-en/s.total.en.html");}
	elseif ($svar == "office") {include("software-en/s.en.office.html");include("software-en/s.total.en.html");}
	elseif ($svar == "os") {include("software-en/s.en.os.html");include("software-en/s.total.en.html");}
	elseif ($svar == "misc") {include("software-en/s.en.misc.html");include("software-en/s.total.en.html");}
	elseif ($svar == "packer") {include("software-en/s.en.packer.html");include("software-en/s.total.en.html");}
	elseif ($svar == "portable") {include("software-en/s.en.portable.html");include("software-en/s.total.en.html");}
	elseif ($svar == "recovery") {include("software-en/s.en.recovery.html");include("software-en/s.total.en.html");}
	elseif ($svar == "security") {include("software-en/s.en.security.html");include("software-en/s.total.en.html");}
	elseif ($svar == "sourcecode") {include("software-en/s.en.sourcecode.html");include("software-en/s.total.en.html");}
	elseif ($svar == "system") {include("software-en/s.en.system.html");include("software-en/s.total.en.html");}
	elseif ($svar == "tv") {include("software-en/s.en.tv.html");include("software-en/s.total.en.html");}
	elseif ($svar == "video") {include("software-en/s.en.video.html");include("software-en/s.total.en.html");}
	elseif ($svar == "all") {include("software-en/view.php");include("software-en/s.total.en.html");}
	elseif ($svar == "magnet") {include("s.magnet.en.html");}
	
    elseif ($svar > "") {echo '<font color="#FF0000"><span style="font-size: x-large">&nbsp;<br></span></font>';include("software-en/s.en.audio.html");include("software-en/s.total.en.html");}
    else {echo '<font color="#FF0000"><span style="font-size: x-large">&nbsp;<br></span></font>';
	include("software-en/s.en.audio.html");include("software-en/s.total.en.html");}
	}	

	
#Links
elseif ($var == "links") {
	echo '<b><font size="8" color="#414141">Links</font></b>';
	include "links/l.cat.html";
	$lvar = $_GET['lcat'];
	if ($lvar == "audio") {
	include("links/l.audio.html");include("links/l.total.en.html");
	}
	elseif ($lvar == "code") {include("links/l.code.html");include("links/l.total.en.html");}
	elseif ($lvar == "design") {include("links/l.design.html");include("links/l.total.en.html");}
    elseif ($lvar == "develope") {include("links/l.develope.html");include("links/l.total.en.html");}
    elseif ($lvar == "document") {include("links/l.document.html");include("links/l.total.en.html");}
    elseif ($lvar == "emulate") {include("links/l.emulate.html");include("links/l.total.en.html");}
    elseif ($lvar == "erotic") {include("links/l.erotic.html");include("links/l.total.en.html");}
    elseif ($lvar == "ftp") {include("links/l.ftp.html");include("links/l.total.en.html");}
	elseif ($lvar == "games") {include("links/l.games.html");include("links/l.total.en.html");}
	elseif ($lvar == "intern") {include("links/l.intern.html");include("links/l.total.en.html");}
    elseif ($lvar == "irc") {include("links/l.irc.html");include("links/l.total.en.html");}
    elseif ($lvar == "link") {include("links/l.link.html");include("links/l.total.en.html");}
    elseif ($lvar == "music") {include("links/l.music.html");include("links/l.total.en.html");}
    elseif ($lvar == "os") {include("links/l.os.html");include("links/l.total.en.html");}
    elseif ($lvar == "portable") {include("links/l.portable.html");include("links/l.total.en.html");}
    elseif ($lvar == "scene") {include("links/l.scene.html");include("links/l.total.en.html");}
    elseif ($lvar == "security") {include("links/l.security.html");include("links/l.total.en.html");}
    elseif ($lvar == "share") {include("links/l.share.html");include("links/l.total.en.html");}
    elseif ($lvar == "storage") {include("links/l.storage.html");include("links/l.total.en.html");}
    elseif ($lvar == "torrent") {include("links/l.torrent.html");include("links/l.total.en.html");}
    elseif ($lvar == "tv") {include("links/l.tv.html");include("links/l.total.en.html");}
    elseif ($lvar == "unlock") {include("links/l.unlock.html");include("links/l.total.en.html");}
    elseif ($lvar == "webmaster") {include("links/l.webmaster.html");include("links/l.total.en.html");}
    elseif ($lvar == "xdcc") {include("links/l.xdcc.html");include("links/l.total.en.html");}
    elseif ($lvar == "all") {include("links/view.php");include("links/l.total.en.html");}
    elseif ($lvar == "") {include("links/l.audio.html");include("links/l.total.en.html");}
    elseif ($lvar > "") {include("links/l.audio.html");include("links/l.total.en.html");}
    else {
	include("links/l.audio.html");include("links/l.total.en.html");}
	}
elseif ($var == "siteinfo") {include("siteinfo.en.php");}
elseif ($var == "more") {include("more.html");}
elseif ($var == "readme") {include("readme.html");}
elseif ($var == "games") {include("games.en.html");}
elseif ($var == "tools") {include("tools.en.html");}
elseif ($var == "readme") {include("readme.html");}
elseif ($var == "tutorials") {include("tutorials.en.html");}
elseif ($var == "") {include("news.en.php");}
elseif ($var > "") {include("news.en.php");}
}




# If category is not given load welcome site

else {
include("news.en.php");
}
?>
<!-- PHP Script End -->
				</td>
			</tr>
		</table>
					<tr>
		<td style="width: 690px; text-align: right">
		<span style="color: rgb(63, 63, 63); font-family: &quot;Trebuchet MS&quot;, &quot;Lucida Sans Unicode&quot;, &quot;Lucida Grande&quot;, &quot;Lucida Sans&quot;, Arial, sans-serif; font-size: x-small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: -webkit-center; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(0, 0, 0); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">
		<font color="#3f3f3f"></font><span>&nbsp;</span></span><a href="main.php?lang=en&&menu=1&&cat=siteinfo" style="color: #3f3f3f; text-decoration: none; font-size: 8pt;" target="_self">SITEINFO</a></td>
	</tr>
		</td>
	</tr>

	<table align="center" style="width: 690px">

	<tr>
<!--		<td style="color: #3F3F3F">© 2017 All Rights Reserved.</td> -->
	<td style="color: #3F3F3F">
		<center><strong>Copyright&nbsp;</strong>&copy; 2012-2020 <a target="_Self" style="color: #3F3F3F; a{color: #FF0000};text-decoration: none;" href="main.php?lang=en&&menu=1&&cat=readme">All Rights Reserved.</a></span></center>
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
