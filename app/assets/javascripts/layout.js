function createMap(info){
	var mapOptions={
         	center: new google.maps.LatLng(info.coords.latitude,info.coords.longitude),
          	zoom: info.zoom || 15,
          	mapTypeId: info.mapType || google.maps.MapTypeId.ROADMAP,
            disableDefaultUI: true,
          	styles: info.style
    };
    var map=new google.maps.Map($('#'+info.mapId).get(0), mapOptions);
    return map;
}

function createMapMarker(map, latitude, longitude){
  var position = new google.maps.LatLng(latitude, longitude);
  var marker = new google.maps.Marker({
      position: position,
      map: map,
      title: 'Hello World!'
  });
}

function geolocation(){
  if (navigator.geolocation){
    navigator.geolocation.getCurrentPosition(set_position, function(error){
      alert('If you don\'t share your location we can\'t find the best offers for you');
      get_location()
    });
  }
}

function get_location(){
  $.get("http://ipinfo.io/geo", function(response) {
      coord=response.loc.split(',');
        var info={
        coords:{latitude:coord[0], longitude:coord[1]},
          zoom:11,
      }
      set_position(info)
  }, "jsonp")
}
 
$(document).ready(function(){

    $('.dropdown_container').click(function() {
        $('.dropdown_items', this).fadeToggle(300)
        $('.dropdown_container:after', this).css("border-width", "0 6px 6px 6px")
    });

    $('#mobile_menu_ctn').click(function() {
        $('#mobile_menu', this).slideToggle(400)
    });
 
});