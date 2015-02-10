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
	var map = createMap(info)
	createMapMarker(map, latitude, longitude)

	$("#tab_bar li").click(function(){
		var id = $(this).data("id")
		$(".tab").hide()
		$("#tab_bar li").removeClass()
		$(id).fadeToggle(300)
		$(this).addClass("active")
	});

});