<style type="text/css">
.sub-description {
	color: #7B7B7B;
}
.color-green {
	color: #00FF00;
}
input { 
	background-color: #333333;
	color: #808080;
	border: solid 1px;
	border-color: #808080;
    font-size: 13pt;
	font-family: Monospace, "Courier New", Courier;
}
input:hover { 
	background-color: #333333;
	color: #00FF00;
	border: solid 1px;
	border-color: #00FF00;
    font-size: 13pt;
	font-family: Monospace, "Courier New", Courier;
}
.auto-style1 {
	color: #FFFFFF;
}
</style>
<title>PS | Indexer</title>

<form method="post" name="Add Site" target="_self">
    <br><span class="color-green"><strong>Indexer</strong></span><span class="auto-style1"> | 
	add.site</span><br><br><br>
	<span class="color-green"><strong>Condition(s)</strong><br></span><br>1. One 
	Site at once, to our Index<br>2. Must be a Communication Protocol, listed 
	below<br>3. Real URL. No 1337, Fake or Spam!<br><br><br>
	<strong><span class="color-green">Allowed</span><br><br>Protocol</strong><br><br>
	ADC, DCHUB, FTP, HTTP, HTTPS, IRC, ONION, TELNET<br><br><strong>
	Domain</strong><br><br>All Extensions given like .com, .onion, .us.to, etc.<br>
	<br><strong>Port</strong><br><br>
	1-65535<br>
	<br><br>
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td class="color-green"><strong>URL</strong><br>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2">
			<input placeholder="protocol://yoursite.domain:port" type="text" name="url" style="width: 701px" size="80"></td>
		</tr>
	</table>
	<br>
    <input type="submit" name="submit" value="Add"></form>
<p>
&nbsp;</p>

<?php
              
if(isset($_POST['url']))
{
$url = $_POST['url'];
	if (filter_var($url, FILTER_VALIDATE_URL)) {
	date_default_timezone_set("Europe/Berlin");
	$timestamp = time();
	$date  = date("Y-m-d, H:i:s", $timestamp);
	$data= '<span style="color:#00FF00;">['.$date.']</span>&nbsp;<a target="_blank" href="'.$_POST['url'].'">'.$_POST['url'].'</a><br>';
	$filename = 'site-indexer-data.html';
		if (is_writable($filename)) {
		$fp = fopen('site-indexer-data.html', 'a');
		fwrite($fp, $data);
		fclose($fp);
		echo '<span style="color: #00FF00"><br><br>Your Site-URL has been successfully added to the Index.<br>';
		echo 'PRESCENE says thanks!</span>';
} 		else {
		chmod("site-indexer-data.html",0777);
		echo '<br><br>Fixed: Access Rights for the Data File on Server.';
		echo '<head><meta http-equiv="refresh" content="2; URL=?to=site:indexer:add"></head>';
}
} 	else {
    echo '<br><br>'.$url . ' is not a valid URL.';
    echo '<head><meta http-equiv="refresh" content="2; URL=?to=site:indexer:add"></head>';
}
}
?>
