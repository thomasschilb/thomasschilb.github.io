<?php
header("Content-Type: text/html; charset=utf-8");
?>
<!doctype html>
<html>
    <head>
		<link rel="icon" type="image/png" href="favicon.png">
        <meta name="content-type" content="text/html; charset=utf-8" />
        <title>Thomas Schilb | TSC</title>
		<link rel="stylesheet" type="text/css" href="style.css" />
    <?php
 
    if(isset($_POST['eintragen'])){
 
        if(!empty($_POST['name']) && trim($_POST['name']) != '' &&
            !empty($_POST['email']) && trim($_POST['email']) != '' &&
            !empty($_POST['nachricht']) && trim($_POST['nachricht']) != ''){
 
            if(!preg_match("^[a-z0-9]+([-_\.]?[a-z0-9])+@[a-z0-9]+([-_\.]?[a-z0-9])+\.[a-z]{2,4}^", $_POST['email'])){
                // Meldung, wenn Email-Adresse ungültig ist:
                ?>
                <p>Please enter a correct Email! e.g. your@email.com</p>
                <p><a href=""></a></p>
                <meta http-equiv="refresh" content="1; URL=../?to=contact">
                </head>
                <body>
                <?php
            }else{
                // Datei öffnen:
                $datei = fopen("tsc-contact-data.txt", "a");
                // Zu schreibenden Inhalt zusammen setzen:
                $inhalt = "<>".str_replace("\n", "<br />", htmlspecialchars($_POST['name']))."\n".
                            date("d.m.Y")."\n".
                            date("H:i")."\n".
                            str_replace("\n", "<br />", htmlspecialchars($_POST['nachricht']))."\n".
                            str_replace("\n", "<br />", htmlspecialchars($_POST['email']))."\n".
                            str_replace("\n", "<br />", htmlspecialchars($_POST['website']));
                // Datei beschreiben:
                fwrite($datei, $inhalt);
                // Datei schließen:
                fclose($datei);
                // Meldung ausgeben:
                ?>
                <p><a href="../?to=contact-complete"></a></p>
                <meta http-equiv="refresh" content="1; URL=../?to=contact-complete">
                </head>
                <body>
                <?php
            }
 
        }else{
            // Meldung, wenn Pflichfelder nicht ausgefüllt wurden:
            ?>
            <p>Please fill out all * tags.</p>
                <p><a href="../?to=contact"></a></p>
                <meta http-equiv="refresh" content="1; URL=../?to=contact">
                </head>
                <body>
            <?php
        }
 
    }
 
    ?>
 
    </body>
</html>
