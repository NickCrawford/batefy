$(document).ready(function(){
	
	$(".submit_btn:not(#signup_finish)").click(function(){
		$(".tab_nav").hide()
		$(".tab").hide()
		$($(this).data("nav-id")).show()
		$($(this).data("tab-id")).fadeToggle(300)
	});

	$(".signup_next").click(function(){
		var active_tab_bar = $("ul li[class=active]")
		active_tab_bar.next().addClass("active")
	});

	$(".signup_back").click(function(){
		var active_tab_bar = $("ul li[class=active]")
		active_tab_bar.last().removeClass("active")
	});

});