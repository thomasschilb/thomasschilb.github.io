
<head>
<style type="text/css">
.auto-style2 {
	color: #808080;
}
a {
	color: #FFFFFF;
	text-decoration: none;
	    -moz-transition: all .3s ease-in;
    -o-transition: all .3s ease-in;
    -webkit-transition: all .3s ease-in;
    transition: all .3s ease-in;
}
</style>
</head>

<font align="right" size="8" color="#3f3f3f"><strong>
<span style="color: #414141">Siteinfo</span></strong></font></span>
<p>&nbsp;</p>
<font color="#808080">
<strong>Author&nbsp;</strong><br><br>since<br><br>
<br><strong>Copyright&nbsp;</strong><br><br>&copy; 2012-2019 All Rights Reserved.</span><br><br>
<br><strong>Version&nbsp;</strong><br><br>v2019.0.3 // Theme: Darkgrey (Red) // 720p<br><br>
<br><strong>Coded in&nbsp;</strong><br><br>CSS // HTML // PHP / MYSQL(i) // Javascript (jQuery)<br>
<br>
<br><strong>Created with&nbsp;</strong><br><br>Photoshop CC (Portable) // Expression Web 4 (Free) // Geany<br>
<br><br>
<strong>IRC (SSL)</strong><br><br>URL:
		<a class="auto-style2" href="irc://irc.anonnet.org/syndicate">
		irc://irc.anonnet.org/syndicate</a><br>Chatzilla: <span class="auto-style2">/sslserver 
		irc.anonnet.org</span><br>
		HexChat: <span class="auto-style2">/server -ssl irc.anonnet.org</span><br>mIRC: <span class="auto-style2">/server -m irc.anonnet.org</span><br>
<br>Channel: #syndicate<br>
<br>
<br><strong>Last Update&nbsp;</strong><br><br>2019-03-13 (YYYY-MM-DD)<br><br>
<br><strong>Count of Visitors&nbsp;</strong>(since 2012)<br><br><?php 
include 'connect.mysqli.php'; // connect db
$count = mysqli_num_rows(mysqli_query($con, "SELECT cid FROM since")); // get entry (rows to number)
$allyearscount = $count + 209787;
echo $allyearscount;
mysqli_close($con); 
?><br><br>
</font>
