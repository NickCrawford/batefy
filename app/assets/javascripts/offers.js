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

$(document).on('click','.subtag_button', function(){
	$('html,body').animate({scrollTop: $("#grid").offset().top},'slow');
});

$(document).on('click','.tag_button', function(){
	var id = $(this).data("tag-id")
	$("#tag_bar").fadeOut(200)
	$("#subtag"+id).delay(200).fadeIn(200)
});

$(document).on('click','.tag_close', function(){
	$(".subtag_bar").fadeOut(200)
	$("#tag_bar").delay(200).fadeIn(200)
});

$(document).on('click','.offer_get_btn', function(){
	$.ajax({
		type:'get',
		url:'user/get_offer/?offer_id='+$(this).data('offer-id'),
		success:function(){
			$(this).html("offer bought!")
		},
	});
});

$(document).on('click','#map_tab', function(){
	$('#position_map_container').fadeIn(300)
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
	map = add_map('position_map')
	add_map_event(map)
}

function add_map(map_name){
	var info={
	    coords:{latitude: latitude ,longitude:longitude},
	    zoom:  15,
	    mapId: map_name
	}
  	return create_map(info)
}

function add_map_event(map){
	google.maps.event.addListener(map, 'dblclick', function(event) {
    	latitude = event.latLng.lat()
    	longitude = event.latLng.lng()
    	set_up_search()
  	});
}