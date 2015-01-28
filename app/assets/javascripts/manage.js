$(document).ready(function(){


	$(".new_toggle").click(function(){
		var id = $(this).data("id")
		$("#"+id).slideToggle(500)
		$(this).toggleClass("active")
	});

	$(".day_toggle, .close").click(function(){
		var id = $(this).data("id")
		$("#"+id).fadeToggle(500)
	});


	$("#month0").css("display","block")
	$(".change_month").click(function(){
		var id = $(this).data("id")
		if (id >= 0 && id+1<=6 ) {
			$(".month").css("display","none")
			$("#month"+id).toggle("slide")
		}
	});

});
