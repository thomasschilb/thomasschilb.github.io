<?php
header('Content-Type: text/html; charset=utf-8');
#$html_data_raw = file_get_contents('https://news.ycombinator.com/');
#$html_data_filter = strip_tags($html_data_raw, '<a><p>');


function getValidUrlsFrompage($source)
  {
    $links = [];
    $content = file_get_contents($source);
    $content = strip_tags($content, "<a>");
    $subString = preg_split("/<\/a>/", $content);
    foreach ($subString as $val) {
      if (strpos($val, "<a href=") !== FALSE) {
        $val = preg_replace("/.*<a\s+href=\"/sm", "", $val);
        $val = preg_replace("/\".*/", "", $val);
        $val = trim($val);
      }
      if (strlen($val) > 0 && filter_var($val, FILTER_VALIDATE_URL)) {
        if (!in_array($val, $links)) {
          $links[] = $val;
        }
      }
    }
    return $links;
  }

$links = getValidUrlsFrompage("https://news.ycombinator.com/");

//Create a new DOM document
$dom = new DOMDocument;

//Parse the HTML. The @ is used to suppress any parsing errors
//that will be thrown if the $html string isn't valid XHTML.
$dom->loadHTML($html_data_filter);

foreach ($dom->getElementsByTagName('a') as $node)
{
  echo '<a href="'.$node->getAttribute('href').'">'.$node->nodeValue.'</a><br><br>';
}

/*
//Get all links. You could also use any other tag name here,
//like 'img' or 'table', to extract other tags.
$links = $dom->getElementsByTagName('a');

//Iterate over the extracted links and display their URLs
foreach ($links as $link){
    //Extract and show the "href" attribute.
    echo $link->nodeValue;
    echo '<a href="' . $link->getAttribute('href'), '"></a><br>';
}
*/

?>