$(document).on('click','.get_offer_btn', function(){
	var button = $(this)
	$.ajax({
		type:'get',
		url:'/user/save_offer/?offer_id='+$(this).data('offer-id'),
		success:function(){
			button.html('Unsave Offer')
			button.removeClass("offer_btn get_offer_btn")
			button.addClass("offer_btn delete_offer_btn")
		},
	})
})

$(document).on('click','.delete_offer_btn', function(){
	var button = $(this)
	$.ajax({
		type:'get',
		url:'/user/unsave_offer/?offer_id='+$(this).data('offer-id'),
		success:function(){
			button.html('Save Offer')
			button.removeClass("offer_btn delete_offer_btn")
			button.addClass("offer_btn get_offer_btn")
		},
	})
})

$(document).on('click','.show_offer',function(){
	var id = $(this).data('id')
	var latitude = $(this).data('latitude')
	var longitude = $(this).data('longitude')
	$("#"+id).fadeToggle(300)
	var info={
		coords:{latitude: latitude,longitude: longitude},
		zoom: 16,
		mapId:'map_'+id,
		style: []
	}
	var map = create_map(info)
	create_map_marker(map, latitude, longitude)

})



