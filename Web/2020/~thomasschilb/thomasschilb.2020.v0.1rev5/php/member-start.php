<!DOCTYPE html>
<html>

<head>
<meta content="de" http-equiv="Content-Language">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<title>Thomas Schilb | TS</title>
<style>

/* BODY */

body {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
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
	color: #31C8F9;
}

/* TABLE */

#tstable {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
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

/* NAVIGATION BAR */

ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #333;
}

li {
  float: left;
}

li a, .dropbtn {
  display: inline-block;
  color: #808080;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

li a:hover, .dropdown:hover .dropbtn {
  background-color: #444;
  color: #31C8F9;
}

li.dropdown {
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #444;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: #808080;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
}

.dropdown-content a:hover {background-color: #555;}

.dropdown:hover .dropdown-content {
  display: block;
}

.auto-style1 {
	color: #FFFFFF;
}

.auto-style2 {
	font-size: 10pt;
	text-align: center;
}

</style>
</head>

<body style="margin: 0; color: #808080; background-color: #000000">
<center>
<p>&nbsp;</p>
<p class="auto-style1">W E L C O M E&nbsp;&nbsp; M E M B E R</p>
<p><font color="white">No. <? include ("php/counter.php"); ?></font></p>
</center>
<p class="auto-style2"><a href="~oldversion/" target="_self">&gt; Click here for 
the old version &lt;</a></p>
</body>

</html>
