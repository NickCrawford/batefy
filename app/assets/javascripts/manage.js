$(document).ready(function(){
	$(".day_toggle").click(function(){
		var id = $(this).data("id")
		$("#"+id).css("display", "block");
	});

	$(".new_toggle").click(function(){
		var id = $(this).data("id")
		$("#"+id).slideToggle(500);
	});	

	$(".close").click(function(){
		var id = $(this).data("id")
		$("#"+id).css("display", "none");
	});	
});
