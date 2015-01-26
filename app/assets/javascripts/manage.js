$(document).ready(function(){
	$(".day_toggle").click(function(){
		var id = $(this).data("id")
		$("#"+id).css("display", "block");
	});

	$(".new_toggle").click(function(){
		var id = $(this).data("id")
		$("#"+id).css("display", "block");
	});	

	$(".close").click(function(){
		var id = $(this).data("id")
		$("#"+id).css("display", "none");
	});	
});
