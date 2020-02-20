<b><font size="8" color="#414141">News</font></b>
<br><br>
<!-- <a class="clicker" target="_blank" id="logo" href="http://www.golem.de/"><img src="img/golem.de.png" alt="golem.de" border="0"></a> -->
<p align="center">- <a target="_blank" style="color: #FF0000" href="https://www.golem.de">Golem.de: IT-News f&uuml;r Profis</a> -</p>
<br>
<?php 
date_default_timezone_set("Europe/Berlin");
$timestamp = time();
$datum = date("d.m.Y",$timestamp); // datum hinzufügen
echo "<table width='600' border='0' cellspacing='0' cellpadding='0' align='center'>";
echo "".$datum."<br><br>";
#include("http://tsc.bplaced.net/golem.html");
echo '<font color="#FFFFFF">';
echo '<iframe style="color: #FFFFFF;" id="I1" name="golem" src="http://syndicate-news.epizy.com/golem.html" border="0" frameborder="0" height="425" marginheight="0" marginwidth="0" scrolling="yes" title="golem" width="660">
cronjob.golem
</iframe>';
echo "</font></table>";
?>
<!--
<br>
<p align="center">- <a target="_blank" style="color: #FF0000" href="http://www.gulli.com/">Gulli.com: Der unabh&auml;ngige IT- und Tech-Kanal!</a> -</p>
<br>
-->
<!-- <script type="text/javascript" src="http://ticker.gulli.com/feed/ticker/view/breaking/width/480/speed/1/newscount/10/target/_blank/"></script>-->
<?php 
#echo '<font color="#FFFFFF">';
#echo '<iframe style="color: #FFFFFF;" id="I1" name="gulli" src="http://tsc.bplaced.net/gulli.html" border="0" frameborder="0" height="300" marginheight="0" marginwidth="0" scrolling="yes" title="ycombinator" width="600">
#http://tsc.bplaced.net/gulli.html
#</iframe>';
#echo '</font>';
#include("http://tsc.bplaced.net/gulli.html");
?>
<br><br>
<p align="center">- <a target="_blank" style="color: #FF0000" href="https://www.heise.de">Heise.de: IT-News, Nachrichten und Hintergr&uuml;nde</a> -</p>
<!-- <a class="clicker" target="_blank" id="logo" href="http://www.heise.de/"><img src="img/heise.de.png" alt="heise" border="0"></a>-->
<br>
<?php
echo "<table width='600' border='0' cellspacing='0' cellpadding='0' align='center'>";
echo '<font color="#FFFFFF">';
echo '<iframe style="color: #FFFFFF;" id="I1" name="heise" src="http://syndicate-news.epizy.com/sidebar1.html" border="0" frameborder="0" height="425" marginheight="0" marginwidth="0" scrolling="yes" title="heise" width="660">
cronjob.heise
</iframe>';
echo '</font>';
#include ("http://tsc.bplaced.net/sidebar1.html"); // ausgabe des gespeicherten
echo "</table>";
?>
<p></p>



</body>
</html>
