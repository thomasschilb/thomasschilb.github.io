<link rel="stylesheet" type="text/css" href="news.css" />
<b><font size="8" color="#414141">News</font></b>
<br><br>
<p align="center">- <a target="_blank" style="color: #FF0000" href="https://news.ycombinator.com/news">Ycombinator.com: Hacker News</a> -</p>
<br>
<?php 
date_default_timezone_set("Europe/Berlin");
$timestamp = time();
$datum = date("d.m.Y",$timestamp); // datum hinzufügen
echo "<table width='600' border='0' cellspacing='0' cellpadding='0' align='center'>";
echo "".$datum."<br><br>";
echo '<iframe id="I1" name="ycombinator" src="http://syndicate-news.epizy.com/ycombinator.html" border="0" frameborder="0" height="700" marginheight="0" marginwidth="0" scrolling="yes" title="ycombinator" width="660">
cronjob.ycombinator
</iframe>
';
echo "</table>";
?>
<p></p>
