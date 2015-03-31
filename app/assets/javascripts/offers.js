$(document).on('click','.get_offer_btn', function(){
	var button = $(this)
	$.ajax({
		type:'get',
		url:'/user/get_offer/?offer_id='+$(this).data('offer-id'),
		success:function(){
			button.html('Remove Offer')
			button.removeClass("offer_btn get_offer_btn")
			button.addClass("offer_btn delete_offer_btn")
		},
	})
})

$(document).on('click','.delete_offer_btn', function(){
	var button = $(this)
	$.ajax({
		type:'get',
		url:'/user/delete_offer/?offer_id='+$(this).data('offer-id'),
		success:function(){
			button.html('Get Offer')
			button.removeClass("offer_btn delete_offer_btn")
			button.addClass("offer_btn get_offer_btn")
		},
	})
})



