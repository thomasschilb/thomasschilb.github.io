<?php
# get url to .html-file

#$rawdata = getHtml('http://syndikat.000webhostapp.com/ycombinator.html');
$rawdata = file_get_contents("http://syndikat.000webhostapp.com/ycombinator.html");

//truncate file to zero (for fresh news)
$fp = fopen("ycombinator.html", "r+");
ftruncate($fp, 0);
fclose($fp);

$datei = fopen("ycombinator.html","a");

# save filtered contect to  .html-file

fwrite($datei, $rawdata);

# view of saved .html-file

include ("ycombinator.html");

# get url to .html-file (function)

function getHtml($url, $post = null) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
    if(!empty($post)) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
    } 
    $result = curl_exec($ch);
    curl_close($ch);
    return $result;
}

?>
