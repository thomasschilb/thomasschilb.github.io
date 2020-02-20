            <!-- START OF LIST -->
			
			<head>
			<title>Thomas Schilb | TSC</title>
			<style type="text/css">
.auto-style1 {
	text-decoration: none;
}
</style>
			</head>

			<body style="a:hover {color: 0000FF;}" link="#000000" vlink="#0000FF" alink="#0000FF" text="#000000" bgcolor="#FFFFFF" topmargin="0" leftmargin="25">
			<font face="Courier" size=4>
			<h2><b><br><font color="#000000">Contact Information: View</font></b></h2></font>
            <hr width="100%" color="#000000" size=5>
			<ol id="guestbook-list">
			<font style="text-decoration: bold;" face="Courier" size=2><b>
            <?php
            $zeige_email = true; // Bestimmt, ob Email angezeigt (true) oder nicht angezeigt (false) werden soll
            $zeige_website = true; // Bestimmt, ob Website-URL angezeigt (true) oder nicht angezeigt (false) werden soll
            // Einlesen und Splitten der Datei:
            $datei = implode(file("tsc-contact-data.txt"));
            $datei = explode("<>", $datei);
            // Sortieren der datei:
            krsort($datei);
            // Schleife für die Ausgabe:
            foreach($datei as $eintrag){
                $daten = explode("\n", $eintrag);
//                $message = wordwrap($daten[3], 60, "\n", true); #zeilenumbruch für user_message
                $message = $daten[3];
                ?></b>
                <li>
                    <b><?php echo $daten[0]; ?></b> on <?php echo $daten[1]; ?> at <?php echo $daten[2]; ?> Uhr
					<p><b>Message:</b></p>
                    <?php echo "<font style='a:hover {color: #000000;}' color='#000000'>" . $message . "</font>"; ?>
                <?php
                // Überprüft, ob Email ausgegeben werden soll
                if($zeige_email === true){
                    ?>
                    <p><b>Email:</b><br><br> <?php echo "<font color='#0000FF'><a style='text-decoration: none; color: #000000;' href='mailto:";echo $daten[4] . "'>". $daten[4] ."</a></font>"; ?></p>
                    <?php
                }
                ?>
                <?php
                // Überprüft, ob Website ausgegeben werden soll
                if($zeige_website === true && $daten[5] != ''){
                    ?>
                    <p><b>Web:</b><br><br> <font color="#000000"><a style="text-decoration: none; color: #000000;" href="http://<?php echo $daten[5]; ?>"><?php echo $daten[5]; ?> </font></a></p>
                    <?php
                }
                ?>
				<hr color="#000000" size="1">
                </li>
                <?php
            }
            ?>
            </ol>
			<center>&copy; 2019 | CI v0.1 |
			<a class="auto-style1" href="http://thomasschilb.tk/" target="_self">
			TSC</a></center><br><br>
            <!-- END OF LIST -->
