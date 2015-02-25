$(".tag_button").click(function(){
	alert("asdkhsdlfkjh")
});

$(document).ready(function(){

	//get user position
	geolocation()
	var geocoder = new google.maps.Geocoder()
});

$(document).on('keyup','#search_field', function(e){
	$(".search_button").attr("href","/fetch_businesses?"+"tag_id="+$("#tag_id").val()+"&subtag_id="+$("#subtag_id").val()+"&search="+$("#search_field").val());
	if(e.which == 13) {
    	$("#search_field_button").click()
    }
});

function set_position(position){
	latitude = position.coords.latitude
  	longitude = position.coords.longitude
  	zoom = position.zoom
}

function display_map(){
	var info={
	    coords:{latitude: latitude ,longitude:longitude},
	    zoom:  zoom || 15,
	    mapId:'google_map',
	}
  	createMap(info)
}
