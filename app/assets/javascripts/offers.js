latitude=''
longitude=''
tag_id=''
subtag_id=''

$(document).ready(function(){
	latitude = $("#latitude").val();
	longitude = $("#longitude").val();
	geolocation()
	display_map()

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
			$("#search_page").html(data)
		}
	});
}

function set_position(position){
	latitude = position.coords.latitude
	longitude = position.coords.longitude
	get_offers()
	display_map()
}

function display_map(){
	var info={
	    coords:{latitude: latitude ,longitude:longitude},
	    zoom:  15,
	    mapId:'position_map',
	}
  	createMap(info)
}