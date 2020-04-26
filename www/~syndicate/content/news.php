<!DOCTYPE html>
<html>

<head>
<meta content="de" http-equiv="Content-Language">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<title>TDS | News</title>
<style>

/* BODY */

body {
  font-family: 'Share Tech Mono';
	}

/* HYPERLINKS */

a {
	color: #808080;
	text-decoration: none;
}
a:visited {
	color: #808080;
}
a:active {
	color: #808080;
}
a:hover {
	color: #FF0000;
}

/* TABLE */

#tstable {
  font-family: 'Share Tech Mono';
  border-collapse: collapse;
}

#tstable td, #tstable th {
  border: 0px solid #333333;
  padding: 8px;
}

#tstable tr:nth-child(even){background-color: #202020;}

#tstable tr:hover {background-color: #444444;}

#tstable th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #333333;
  color: white;
}

/* FONT, MISC */

.font-normal {
	font-weight: normal;
}

.auto-style2 {
	font-size: 10pt;
	text-align: center;
}

.auto-style5 {
	font-size: medium;
	text-align: left;
	font-weight: normal;
	color: #FFFFFF;
}
.auto-style6 {
	text-align: center;
	color: #FFFFFF;
}

</style>


<body style="margin: 0; color: #808080; background-color: #000000">
<p class="auto-style6">
N E W S</p>
<p class="auto-style6">
&nbsp;</p>
<p class="auto-style2">
<table id="tstable" cellpadding="15" cellspacing="0" style="width: 100%">
	<tr>
		<th colspan="3" class="auto-style5">Information & Technical</th>
	</tr><tr>
		<? include("it-news.php"); ?></tr>
	</table>
</p><p>&nbsp;</p>
<p class="auto-style2">
<table id="tstable" cellpadding="15" cellspacing="0" style="width: 100%">
	<tr>
		<th colspan="3" class="auto-style5">Information & Technical | Latest</th>
	</tr><tr>
		<? include("it-news-latest.php"); ?></tr>
	</table>
</p>
<p class="auto-style2"><em>Comment: "Get the latest of Information & Technical News."</em></p>
<p>&nbsp;</p>
</head>
</body>

</html>
