$(document).ready(function(){

	//get user position
	geolocation();
	var geocoder = new google.maps.Geocoder();
});

function found_position(position){
	var latitude =position.coords.latitude;
  	var longitude =position.coords.longitude;
	var info={
	    coords:{latitude: latitude ,longitude:longitude},
	    zoom: position.zoom || 15,
	    mapId:'google_map',
	}
  	createMap(info)
}