
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
.auto-style4 {
	color: #3F3F3F;
}
</style>
</head>

<font align="right" size="8" color="#3f3f3f"><strong>
<span style="color: #414141">Siteinfo</span></strong></font></span>
<p>&nbsp;</p>
<font color="#808080">
<strong>Autor(s)</strong><br><br>ts, tsc, since, unimatrix, 8ball<br><br>
<br><strong>Copyright&nbsp;</strong><br><br>2012-2021 SYNDICATE. Alle Rechte Vorbehalten.</span><br><br>
<br><strong>Version&nbsp;</strong><br><br>v2019.0.5.1 // Thema: Dunkelgrau (Rot) // 720p<br><br>
<br><strong>Programmiert in&nbsp;</strong><br><br>CSS3 // HTML5 // PHP7+ // MYSQLi<br><br>
<br><strong>Erstellt mit&nbsp;</strong><br><br>
<a href="https://www.fcportables.com/portable-photoshop/" target="_blank">Adobe Photoshop CC (Portable)</a><span class="auto-style4"> 
// 2D-DESIGN</span><br>
<a href="https://www.microsoft.com/en-us/download/details.aspx?id=36179" target="_blank">Microsoft Expression Web 4 (Free)</a><span class="auto-style4"> 
// WYSIWYG-WEBEDITOR</span><br><a href="https://geany.org/" target="_blank">Geany (Open-Source)</a><span class="auto-style4"> 
// CODE-TEXTEDITOR</span><br><br>
<br>
<strong>Banner</strong><br><br>Gross<br><br>
<img height="60" src="img/banner.gif" width="468"><br>
</font>
<span class="auto-style3"><em>468x60px</em></span><font color="#808080"><br><br>
Klein<br><br><img height="31" src="img/banner-small.gif" width="88"><br>
</font>
<span class="auto-style3"><em>88x31px</em></span><font color="#808080"><br><br><br>
<span class="auto-style2"><strong>Linke Uns!</strong></span><span class="auto-style4"><br>
<br><a href="http://www.digital-syndicate.net">www.digital-syndicate.net</a></span><br>
<br><br>
<strong>IRC (NOSSL)</strong><br><br>Server: irc.thomasschilb.net<br>Channel: #syndicate<br>
Link: <a href="irc://irc.thomasschilb.net/syndicate">
irc://irc.thomasschilb.net/syndicate</a><br>
<br>
<br><strong>Letztes Update&nbsp;</strong><br><br>2019-12-11 (YYYY-MM-DD)<br><br>
<br><strong>Besucheranzahl&nbsp;</strong>(seit 2012)<br><br><?php 
include 'connect.mysqli.php'; // connect db
$count = mysqli_num_rows(mysqli_query($con, "SELECT cid FROM syndicate")); // get entry (rows to number)
$allyearscount = $count + 275613;
echo $allyearscount;
mysqli_close($con); 
?><br><br>
</font>
