
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
.auto-style3 {
	color: #414141;
}
</style>
</head>

<font align="right" size="8" color="#3f3f3f"><strong>
<span style="color: #414141">Siteinfo</span></strong></font></span>
<p>&nbsp;</p>
<font color="#808080">
<strong>Autor&nbsp;</strong><br><br>tsc, since<br><br>
<br><strong>Copyright&nbsp;</strong><br><br>2012-2020 SYNDICATE. Alle Rechte Vorbehalten.</span><br><br>
<br><strong>Version&nbsp;</strong><br><br>v2019.0.3.3 // Thema: Dunkelgrau (Rot) // 720p<br><br>
<br><strong>Programmiert in&nbsp;</strong><br><br>CSS3 // HTML5 // PHP7+ / MYSQL 
(MariaDB) // Javascript (jQuery)<br><br>
<br><strong>Erstellt mit&nbsp;</strong><br><br>Photoshop CC (Portable) // Expression Web 4 (Frei) // Geany<br><br>
<br>
<strong>Banner</strong><br><br>Gross<br><br>
<img height="60" src="img/banner.gif" width="468"><br>
</font>
<span class="auto-style3"><em>468x60px</em></span><font color="#808080"><br><br>
Klein<br><br><img height="31" src="img/banner-small.gif" width="88"><br>
</font>
<span class="auto-style3"><em>88x31px</em></span><font color="#808080"><br><br>
Linke zu: <a href="http://syndicate.cf" target="_blank">http://syndicate.cf</a> oder
<a href="http://the-digital-syndicate.cf" target="_blank">http://the-digital-syndicate.cf</a><br><br>
<br><strong>IRC (SSL)</strong><br><br>URL:
		<a class="auto-style2" href="irc://irc.anonnet.org/syndicate">
		irc://irc.anonnet.org/syndicate</a><br>Chatzilla: <span class="auto-style2">/sslserver 
		irc.anonnet.org</span><br>
		HexChat: <span class="auto-style2">/server -ssl irc.anonnet.org</span><br>mIRC: <span class="auto-style2">/server -m irc.anonnet.org<br>
<br>Channel: #syndicate<br></span>
<br>
<br><strong>Letztes Update&nbsp;</strong><br><br>2019-08-16 (JJJJ-MM-TT)<br><br>
<br><strong>Besucheranzahl&nbsp;</strong>(2012-2020)<br><br><?php 
include 'connect.mysqli.php'; // connect db
$count = mysqli_num_rows(mysqli_query($con, "SELECT cid FROM since")); // get entry (rows to number)
$allyearscount = $count + 209787;
echo $allyearscount;
mysqli_close($con); 
?><br><br>
</font>
