
<head>
<meta content="de" http-equiv="Content-Language">
<style type="text/css">
.text-center {
	text-align: center;
}
.text-10pt-center {
	text-align: center;
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
}
.text-10pt {
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
}
.text-10pt-fontsize {
	font-size: 10pt;
}
.text-cat-details {
	text-align: center;
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
	color: #333333;
}
.text-left {
	text-align: left;
}
a:hover {
	color: #FFFFFF;
}
.copyright {
	color: #7B7B7B;
	text-align: center;
	font-family: "Courier New", Courier, monospace;
	font-size: 10pt;
}
.text-center5 {
	color: #FFFFFF;
}
.text-darkgrey {
	color: #777777;
}
.welcome {
	text-align: left;
	color: #7B7B7B;
}
.text-center2 {
	color: #FFFFFF;
}
.auto-style1 {
	color: #7B7B7B;
}
</style>
</head>

<body style="background-color: #000000">

<p name="TOP" class="text-10pt-center">&nbsp;</p>
<table align="center" cellpadding="0" cellspacing="0" style="width: 600">
	<tr>
		<td class="text-center">
		<a href="?to=gate" target="_self" title="Link Us!">

		<img height="62" src="img/prescene-title.png" width="370" class="text-10pt"></td>
	</tr>
	<tr>
		<td class="text-10pt">&nbsp;</td>
	</tr>
	<tr>
		<td class="text-10pt-center">
		<a href="#BBS" target="_self" title="[bbs.client.server.dl.search.news]">.BBS</a>
		<a href="#EMULE" target="_self" title="[clients.mods.sites.serverlists.kad]">.EMULE</a>
		<a href="#FTP" target="_self" title="[ftp.client.server.dl.search]">.FTP</a>
		<a href="#ONION" target="_self" title="[darknet.deepweb.onion.tor.linklist.search.dl]">.ONION</a>
		<a href="#TORRENT" target="_self" title="[torrents.magnet.dl.search.tracker]">.TORRENT</a>
		<a href="#USENET" target="_self" title="[binaries.news.read.dl.search]">.USENET</a>
		<span class="text-center2">
		<a href="#WEB" target="_self" title="[0day-releases.zer0day.pre.web.search.dl]">.WEB</a></span>
		<a href="#XDCC" target="_self" title="[bots.channels.network.packets.dl.search]">.XDCC</a><span class="auto-style1"> 
		| VIEW: <a href="?to=view-single" target="_self">SINGLE</a></span></td>
	</tr>
	<tr>
		<td class="text-10pt-center">
		&nbsp;</td>
	</tr>
	<tr>
		<td class="text-10pt">
		<img height="1" src="img/prescene-line.png" width="600"></td>
	</tr>
	<tr>
		<td class="text-10pt">
		<?php 
		echo "<br>";include("php/view-all/view-bbs.php");
		echo "<br>";include("php/view-all/view-emule.php");
		echo "<br>";include("php/view-all/view-ftp.php");
		echo "<br>";include("php/view-all/view-onion.php");	
		echo "<br>";include("php/view-all/view-torrent.php");
		echo "<br>";include("php/view-all/view-usenet.php");
		echo "<br>";include("php/view-all/view-web.php");
		echo "<br>";include("php/view-all/view-xdcc.php");
		?>
		</td>
	</tr>
	<tr>
		<td class="copyright" style="height: 16px">
		Copyright &copy; 2019 <a href="?to=site" target="_self">PRESCENE.</a><br><?php echo"<br><br>";include('counter.php');?>&nbsp;</td>
	</tr>
</table>	
