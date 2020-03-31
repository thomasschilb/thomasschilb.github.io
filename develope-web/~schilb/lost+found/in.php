<html>
<head>
<?php
$usr = "schilb";$psw = "0001355";
$username = '$_POST[username]';$password = '$_POST[password]';
session_start();
if ($_SESSION['login']==true || ($_POST['username']=="schilb" && $_POST['password']=="0001355")) {
echo '<meta target="_self" http-equiv="refresh" content="0; URL=https://schilb.info/?=ok">';
$_SESSION['login']=true;
}
else {
echo '<meta target="_self" http-equiv="refresh" content="0; URL=https://schilb.info">';
}
?>
</head>
<body></body>
</html>