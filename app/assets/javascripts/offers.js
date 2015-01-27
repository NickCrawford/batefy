$(document).ready(function(){

	//get user position
	geolocation()
	var geocoder = new google.maps.Geocoder()
});

function set_position(position){
	latitude = position.coords.latitude
  	longitude = position.coords.longitude
  	zoom = position.zoom
  	display_map()
}

function display_map(){
	var info={
	    coords:{latitude: latitude ,longitude:longitude},
	    zoom:  zoom || 15,
	    mapId:'google_map',
	}
  	createMap(info)
}