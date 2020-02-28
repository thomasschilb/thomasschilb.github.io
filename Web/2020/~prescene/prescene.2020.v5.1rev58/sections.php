<br><strong>Site-URL Indexer | site.sections</strong><br><br>
<?
//truncate file to zero (for fresh news)
$fp = fopen("sections.html", "r+");
ftruncate($fp, 0);
fclose($fp);

$url='http://prescene.us.to/sections.html';
//fopen opens webpage in Binary
$handle=fopen($url,"rb");
// initialize
$lines_string="";
// read content line by line
do{
	$data=fread($handle,1024);
	if(strlen($data)==0) {
		break;
	}
	$lines_string .= $data;
}while(true);
//close handle to release resources
fclose($handle);
//output, you can also save it locally on the server

$datei = fopen('sections.html','a');

# filter content
$filter1 = strip_tags($lines_string, '<a>'); // alle html tags ausser a entfernen
#$filter2 = cleanEmptyspaces($filter1); // alle leerzeichen entfernen
$filter2 = str_replace('</a>' , '</a><br>' , $filter1); // punkt hinzufügen

fwrite($datei, $filter2); // filter content speichern

include ("sections.html"); // ausgabe des gespeicherten

?>
