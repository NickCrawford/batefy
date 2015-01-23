$(document).ready(function(){

	//creating map
	var latitude = $("input[name='latitude']").val()
	var longitude = $("input[name='longitude']").val()
	var info={
		coords:{latitude: latitude,longitude: longitude},
		zoom: 15,
		mapId:'profile_header',
		style: [{"featureType": "all","elementType": "all", "stylers": [
            {"invert_lightness": true},{"saturation": 10},
            {"lightness": 30},{"gamma": 0.5},{"hue": "#435158"}]}]
	}
	var map = createMap(info)
	createMapMarker(map, latitude, longitude)

});