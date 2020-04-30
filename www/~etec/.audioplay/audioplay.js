<script src="audioplay-jquery.js"></script>

<script>
jQuery(document).ready(function( $ ) {
	$("audio").on("play", function (me) {
		$("audio").each(function (i,e) {
			if (e !== me.currentTarget) {
				this.pause(); 
				this.currentTime = 0;
			}
		});
	});
})

function play(e) {
	var de = document.getElementById(e);

	var div = document.getElementsByClassName('playlist_container')[0];
	
	// alle Buttons löschen
	var number = div.getElementsByTagName('input').length;
	for (var i = 0, n = number; i < n; i++){
		div.getElementsByTagName('input')[i].style.background="none";
	}

	if (de.paused) {
		// Cachen eines streams vermeiden: (nur, wenn die JavaScript Funktionalität verwendet wird, und nicht, wenn die nativen audio-controls benutzt werden)
		url = de.src.split("?")[0];
		var de1 = url  + "?" + new Date().getTime();
		document.getElementById(e).src = de1;
		
		// aktiven Sender mit einem Button kennzeichnen:
		div.getElementsByTagName('input')[e-1].style.background="url('/images/button_12.png') no-repeat 2px 2px / 12px";
				
		de.play();
		de.style.display="block";
		de.onended = function (){
			if (document.getElementById(e+1)) {
				play(e+1);
			} else {
				play(1);
			}
		}
	} else {
		de.pause();
	}
}
</script>