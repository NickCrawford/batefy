$(document).ready(function(){
	
	$(".submit_btn").click(function(){
		$(".tab_nav").hide()
		$(".tab").hide()
		$($(this).data("nav_id")).show()
		$($(this).data("tab_id")).show()
	});

});