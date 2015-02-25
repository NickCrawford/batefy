var map_style = []

$(document).ready(function(){


	$("#tab_bar li").click(function(){
		var id = $(this).data("id")
		$(".tab").hide()
		$("#tab_bar li").removeClass()
		$(id).fadeToggle(500)
		$(this).addClass("active")
	});

});