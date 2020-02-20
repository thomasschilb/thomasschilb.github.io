<?php
/* 
   IT Newsgrabber for XML | Latest
   --------------------------------
   Version: 0.2
   Author: Thomas Schilb
   Email: thomas.schilb@live.de
   Last Update: 2020/02/20
   Filename: it-news-latest.php
   --------------------------------
*/
/* header in utf-8 */
header('Content-Type: text/html; charset=utf-8');
/* simplexml load file from url */
$xml_file=simplexml_load_file("https://hnrss.org/newest.atom") or die("Error: Cannot load from file");
/* prepare the content, make arrays, filter content */
foreach($xml_file->children() as $entries) {
$title = $entries->title;
$link = $entries->link[href];
$xml_data_title = array($title);
$xml_data_link  = array($link);
if ($xml_data_title[0] == "") {} // Ignore Nullified Content
else {
$xml_raw_data = '<tr><td>'.$xml_data_title[0].'<td><td><a href="'.$xml_data_link[0].'"><img style="float:right" src="img/www.png"></a></td></tr>';
$xml_filter_00 = str_replace('<a href=""></a><br><br>','',$xml_raw_data);;
$xml_filter_01 = str_replace('<a href="','<a target="_blank" href="',$xml_filter_00);;
$xml_data = $xml_filter_01;
/* show content, title & link */
echo $xml_data;}
}
?>