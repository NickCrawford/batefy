var map_style = []

$(document).ready(function(){

	//creating map
	var latitude = $("input[name='latitude']").val()
	var longitude = $("input[name='longitude']").val()
	var info={
		coords:{latitude: latitude,longitude: longitude},
		zoom: 15,
		mapId:'map_header',
		style: map_style
	}
	var map = create_map(info)
	create_map_marker(map, latitude, longitude)

	$("#tab_bar li").click(function(){
		var id = $(this).data("id")
		$(".tab").hide()
		$("#tab_bar li").removeClass()
		$(id).fadeToggle(300)
		$(this).addClass("active")
	});

	$("input").keydown(function(e){
		if(e.which==13){
			e.preventDefault()
		}
	});

	$("#profile_submit").click(function(){
		$("#confirm").show()
		$("#confirm").css("pointer-events","auto")
	});
	
	$("#modal_close").click(function(){
		$("#confirm").hide()
	});

});