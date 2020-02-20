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

foreach($links as $key=>$value)
{
    unset($links[$key + 1]);
    echo '<a href="'.$value.'">'.$value.'</a><br>';
}
?>