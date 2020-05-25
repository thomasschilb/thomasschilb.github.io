<?
#  chmod the "gb.html" for write access [e.g. 777]

;$inpname=htmlentities(trim($_POST["inpname"]))
;$inptext=htmlentities(trim($_POST["inptext"]))

;if (($inpname=="") || ($inptext=="")) die("Bitte etwas eingeben!")

;$cont=file_get_contents("gb.html")

;if (($cont=="") || (strlen($cont)<32)) die("Fehler, Datenbank konnte nicht geladen werden.")

;if ($fh=fopen("gb.html","w")) ;else die("Fehler, Datenbank konnte nicht geschrieben werden.")

;fputs($fh,str_replace("<!-- Eintrag -->","<!-- Eintrag --><br><br><b>".$inpname.":</b> <small>(".date("d.m.y.H:i.s").")</small><br>".$inptext."",$cont))

;fclose($fh)

;header("Location: index.php?link_id=6")

?>