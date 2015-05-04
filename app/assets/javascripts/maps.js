latitude=''
longitude=''

function geolocation(success_callback, failur_callback){
  $("#spinner").show()
  if (navigator.geolocation){
    navigator.geolocation.getCurrentPosition(function(position){
      $("#spinner").hide()
      latitude = position.coords.latitude
      longitude = position.coords.longitude
      success_callback()
    }, function(error){
      $("#spinner").hide()
      failur_callback()
    });
  }
}

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

function get_directions(){
  window.open("https://www.google.com/maps/dir/"+latitude+","+longitude+"/"+business_address)
}

function get_non_accurate_directions(){
  alert("Share your location for a better user experience.")
  window.open("https://www.google.com/maps/dir//"+business_address)
}

function alert_geolocation(){
  alert("You need to share your position to use this feature.")
}

$(document).on('click','.get_directions',function(){
  business_address = $(this).data("address")
  geolocation(get_directions,get_non_accurate_directions)
})
