latitude=''
longitude=''
tag_id=''
subtag_id=''

$(document).ready(function(){
	latitude = $("#latitude").val();
	longitude = $("#longitude").val();
	geolocation()
	set_up_search()
});

$(document).on('click','.search_button', function(){
	tag_id = $(this).data('tag-id')
	subtag_id = $(this).data('subtag-id')
	get_offers()
});

$(document).on('click','.tag_button', function(){
	$(".subtag_button").hide(500)

	var id = $(this).data("tag-id")

	$(".tag_button").not(this).hide(500)
	$("#tag_close").css("display","inline-block")

	$("#"+id).show(500)
});

function get_offers(){
	//alert("latitude:"+latitude+" longitude:"+longitude+" tag_id:"+tag_id+" subtag_id:"+subtag_id)
	$.ajax({
		type:'get',
		url:'offers/show/?latitude='+latitude+'&longitude='+longitude+'&tag_id='+tag_id+'&subtag_id='+subtag_id,
		success:function(data){
			$("#grid").html(data)
		}
	});
}

function set_position(position){
	latitude = position.coords.latitude
	longitude = position.coords.longitude
	set_up_search()
}

function set_up_search(){
	get_offers()
	map = add_map()
	add_map_event(map)
}

function add_map(){
	alert("hi")
	var info={
	    coords:{latitude: latitude ,longitude:longitude},
	    zoom:  15,
	    mapId:'position_map'
	}
  	return create_map(info)
}

function add_map_event(map){
	google.maps.event.addListener(map, 'dblclick', function(event) {
    	alert("hello")
    	latitude = event.latLng.lat()
    	longitude = event.latLng.lng()
    	set_up_search()
  	});
}