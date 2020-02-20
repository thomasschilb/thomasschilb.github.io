
<head>
<style type="text/css">
.sub-description {
	color: #7B7B7B;
}
</style>
</head>

<form method="post" name="Add Site" target="_self">
    <br><strong>Site-URL Indexer | add.valid.site-urls</strong><br><br>
	<span class="sub-description">
	Please add only one site-url at once...</span><br>
	<br><br>
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td>URL:&nbsp;</td>
			<td><input placeholder="e.g. https://www.site.com, telnet://whq.site.com, http://site.onion, etc." type="text" name="url" style="width: 442px" size="80"></td>
		</tr>
	</table>
	<br>
    <input type="submit" name="submit" value="OK"></form>
<?php
              
if(isset($_POST['url']))
{
$url = $_POST['url'];
	if (filter_var($url, FILTER_VALIDATE_URL)) {
	date_default_timezone_set("Europe/Berlin");
	$timestamp = time();
	$date  = date("Y-m-d, H:i:s", $timestamp);
	$data= '['.$date.']&nbsp;<a target="_blank" href="'.$_POST['url'].'">'.$_POST['url'].'</a><br>';
	$filename = 'site-indexer-data.html';
		if (is_writable($filename)) {
		$fp = fopen('site-indexer-data.html', 'a');
		fwrite($fp, $data);
		fclose($fp);
		echo '<br><br>The site-url has been successfully added.<br>';
		echo 'PRESCENE says thanks! Click <a target="_self" href="?to=site:indexer:livelist">here</a> for Site-URL Indexer Livelist.<br><br>';
		echo '<i>Have you got another one? If not, then please <a target="_self" href="http://prescene.us.to">leave</a> now.</i>';
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
