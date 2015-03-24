function create_map(info){
	var mapOptions={
         	center: new google.maps.LatLng(info.coords.latitude,info.coords.longitude),
          	zoom: info.zoom || 15,
            scrollWheel: info.scrollable || true,
          	mapTypeId: info.mapType || google.maps.MapTypeId.ROADMAP,
            disableDefaultUI: true,
          	styles: info.style
    };
    var map=new google.maps.Map($('#'+info.mapId).get(0), mapOptions);
    return map;
}

function create_map_marker(map, latitude, longitude){
  var position = new google.maps.LatLng(latitude, longitude);
  var marker = new google.maps.Marker({
      position: position,
      map: map
  });
}

function get_address_from_coordinates(coordinates){
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode({'latLng': coordinates}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      if (results[1]) {
        return  results[1].formatted_address
      }
    }
    return "Could not create address"
  });
}