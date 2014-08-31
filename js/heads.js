function highlightHead() {
	if(window.location.hash) {
		// Get name & Reset.
		var name = window.location.hash.substring(1);
		$(".item-info").removeClass("highlighted");
		
		//Start Animation
		var head = $("#"+name+".item-info");
		head[0].scrollIntoView( true );
		head.animate({
			backgroundColor: "#CEFFE6"
		}, 500);
		head.animate({
			backgroundColor: ""
		}, 1000);
	}
}

$(window).bind('hashchange', highlightHead)
$(window).ready(function(){highlightHead();});