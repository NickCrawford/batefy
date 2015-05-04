var deleted_offer_element
var deleted_offer_button

$(document).on('click','.get_offer_btn', function(){
	var button = $(this)

	$.ajax({
		type:'get',
		url:'/user/save_offer/?offer_id='+$(this).data('offer-id'),
		success:function(){
			$(".offer_id_"+button.data('offer-id')).html('Unsave Offer')
			$(".offer_id_"+button.data('offer-id')).removeClass("submit_btn get_offer_btn")
			$(".offer_id_"+button.data('offer-id')).addClass("submit_btn delete_offer_btn")
		},
	})
})

$(document).on('click','.delete_offer_btn', function(){
	var button = $(this)
	$.ajax({
		type:'get',
		url:'/user/unsave_offer/?offer_id='+$(this).data('offer-id'),
		success:function(){
			$(".offer_id_"+button.data('offer-id')).html('Save Offer')
			$(".offer_id_"+button.data('offer-id')).removeClass("submit_btn delete_offer_btn")
			$(".offer_id_"+button.data('offer-id')).addClass("submit_btn get_offer_btn")
		},
	})
	if(window.location.pathname == '/user/my_offers') {
		deleted_offer_element = button.parent().parent().parent()
		deleted_offer_button = button
        button.parent().parent().parent().fadeOut(300)
        $('.notices').slideToggle(300)
    }
})

$(document).on('click', '#undo', function() {
	deleted_offer_element.fadeIn(300)
	$('.notices').slideToggle(300)
	$.ajax({
		type:'get',
		url:'/user/save_offer/?offer_id='+deleted_offer_button.data('offer-id'),
		success:function(){
			$(".offer_id_"+deleted_offer_button.data('offer-id')).html('Unsave Offer')
			$(".offer_id_"+deleted_offer_button.data('offer-id')).removeClass("submit_btn get_offer_btn")
			$(".offer_id_"+deleted_offer_button.data('offer-id')).addClass("submit_btn delete_offer_btn")
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

$(document).on('click','.toggle_info',function(){
	$('.info_content').toggle()
	if ($(this).html()=="More Info") {
		$('.toggle_info').html("Less Info")
	} else {
		$('.toggle_info').html("More Info")
	}
})	

