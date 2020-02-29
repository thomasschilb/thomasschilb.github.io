<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>TS | Login</title>
    <link rel="stylesheet" href="login-style.css"/>
	<style type="text/css">
.auto-style1 {
	text-align: center;
	color: #FFFFFF;
}
</style>
</head>
<body style="background-color: #000000">
<?php
    require('db.php');
    session_start();
    // When form submitted, check and create user session.
    if (isset($_POST['username'])) {
        $username = stripslashes($_REQUEST['username']);    // removes backslashes
        $username = mysqli_real_escape_string($con, $username);
        $password = stripslashes($_REQUEST['password']);
        $password = mysqli_real_escape_string($con, $password);
        // Check user is exist in the database
        $query    = "SELECT * FROM `users` WHERE username='$username'
                     AND password='" . md5($password) . "'";
        $result = mysqli_query($con, $query) or die(mysql_error());
        $rows = mysqli_num_rows($result);
        if ($rows == 1) {
            $_SESSION['username'] = $username;
            // Redirect to user dashboard page
            #header("Location: dashboard.php");
            ?><meta http-equiv="refresh" content="0; URL=member/"><?
        } else {
            echo '<div class="form">
                  <h3>Incorrect Username/password.</h3><br/>
                  <p class="link">Click here to <a target="_self" href=""?to=login">Login</a> again.</p>
                  </div>';
        }
    } else {
?><p class="auto-style1">L O G I N</p>
    <form class="form" method="post" name="login" target="_self">
        <!--<h1 class="login-title">TS | Login</h1>-->
        <input type="text" class="login-input" name="username" placeholder="Username" autofocus="true"/>
        <input type="password" class="login-input" name="password" placeholder="Password"/>
        <input type="submit" value="Login" name="submit" target="_self" class="login-button"/>
        <p class="link">Don't have an account? <a target="_self" href="?to=register">Register Now!</a></p>
  </form>
<?php
    }
?>
</body>
</html>
