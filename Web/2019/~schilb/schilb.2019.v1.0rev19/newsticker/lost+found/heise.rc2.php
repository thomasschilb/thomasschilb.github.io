<?php

//truncate file to zero (for fresh news)
$fp = fopen("heise.xml", "r+");
ftruncate($fp, 0);
fclose($fp);


$url='https://www.heise.de/rss/heise-atom.xml';
//fopen opens webpage in Binary
$handle=fopen($url,"rb");
// initialize
$content="";
// read content line by line
do{
	$data=fread($handle,1024);
	if(strlen($data)==0) {
		break;
	}
	$content.=$data;
}while(true);
//close handle to release resources
fclose($handle);


//load local file, to replace something
$file = fopen("heise.xml","a");
$filter = $content;
$filter1 = str_replace('<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>','',$filter);
$filter2 = str_replace('','',$filter1);
$filter3 = str_replace('','',$filter2);
$filter4 = str_replace('','',$filter3);
$content_filtered = str_replace('','',$filter4);
fwrite($file, $content_filtered); //write file, language
fclose($file);

//load file, simplexml, to filter content
$xml_file=simplexml_load_file("heise.xml") or die("Error: Cannot create object");
$xml=$xml_file;
foreach($xml->children() as $entries) {
    echo $entries->title . "<br>";
    echo $entries->link . "<br>";
}
#$file = fopen("heise.xml","a");
#fwrite($file, $set_lang_de); //write file, language

//method3
#$xml=simplexml_load_string($content) or die("Error: Cannot create object");
#echo $xml;
#$file_content=$xml->a . "<br>";

//method2
#$filter1 = '/<a>(.*)<\/a>/';
#preg_match($filter1, $content, $matches);
#echo $matches[1];echo '<br />';
#$content1 = '' . $matches[1] . '<br />';

//method1
#$filter1 = strip_tags($content, '<title><a>');
#$filter2 = str_replace('<title type="text">','<br><span><b>',$filter1);
#$filter3 = str_replace('</title>','</b></span><br>',$filter2);
#$filter4 = str_replace('</a>','LINK</a><br>',$filter3);
#$filter5 = strip_tags($filter4, '<span><a><b><br>');
#$filter6 = cleanEmptyspace($lines_string_filtered5);


#include ("heise.html"); // ausgabe des gespeicherten
?>
