<?php

// get FTP access parameters

$host = $_POST['host'];

$user = $_POST['user'];

$pass = $_POST['pass'];

$destDir = $_POST['dir'];

$workDir = "/home/ftp/data/incoming"; // define this as per local system

// get temporary file name for the uploaded file

$tmpName = basename($_FILES['file']['tmp_name']);

// copy uploaded file into current directory

move_uploaded_file($_FILES['file']['tmp_name'], $workDir."/".$tmpName) or die("Cannot move uploaded file to working directory");

// open connection

$conn = ftp_connect($host) or die ("Cannot initiate connection to host");

// send access parameters

ftp_login($conn, $user, $pass) or die("Cannot login");

// perform file upload

$upload = ftp_put($conn, $destDir."/".$_FILES['file']['name'], $workDir."/".$tmpName, FTP_BINARY);

// check upload status

// display message

if (!$upload) {

    echo "Cannot upload!";

} else {

    echo "Upload complete.";

}

// close the FTP stream

ftp_close($conn);

// delete local copy of uploaded file

unlink($workDir."/".$tmpName) or die("Cannot delete uploaded file from working directory -- manual deletion recommended");

?>