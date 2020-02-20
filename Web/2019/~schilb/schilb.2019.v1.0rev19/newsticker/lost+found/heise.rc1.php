<!-- http://www.heise.de/newsticker/sidebar1.html

<?php
// Lese 14 Zeichen, beginnend mit dem 21. Zeichen
$section = file_get_contents('https://www.heise.de/rss/heise-atom.xml', NULL, NULL, 20, 14);
var_dump($section);
?>

-->

<?php

  function cleanEmptyspace($string) { 
    return trim( preg_replace('/\s+/', ' ', $string) ); 
} 

//truncate file to zero (for fresh news)
$fp = fopen("sidebar1.html", "r+");
ftruncate($fp, 0);
fclose($fp);

$url='https://www.heise.de/rss/heise-atom.xml';
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
	$lines_string.=$data;
}while(true);
//close handle to release resources
fclose($handle);
//output, you can also save it locally on the server

$datei = fopen("sidebar1.html","a");

# filter content
$lines_string_filtered1 = strip_tags($lines_string, '<title><link>'); // alle html tags ausser p und a entfernen
#$lines_string_filtered2 = substr($lines_string_filtered1, 190); // entfernen erste 190 zeichen 
$lines_string_filtered2 = cleanEmptyspace($lines_string_filtered1); // entfernen alle leerzeichen 
$lines_string_filtered3 = str_replace('<link','<br><a',$lines_string_filtered2);
$lines_string_filtered4 = str_replace('</link>','</a><br>',$lines_string_filtered3);
$lines_string_filtered5 = str_replace('<title type="text">','<br><br><b>',$lines_string_filtered4);
$lines_string_filtered6 = str_replace('</title>','</b><br>',$lines_string_filtered5);


fwrite($datei, $lines_string_filtered6); // filter content speichern
include ("sidebar1.html"); // ausgabe des gespeicherten
?>
