latitude=''
longitude=''
tag_id=''
subtag_id=''

$(document).ready(function(){
	latitude = $("#latitude").val();
	longitude = $("#longitude").val();
	get_offers()
	$(".info_close").click(function(){
		$(".info_bar").slideToggle(300)
	});

	$(".info_tab").click(function(){
		$(".info_bar").slideToggle(300)
	});
});

$(document).on('click','.search_button', function(){
	tag_id = $(this).data('tag-id')
	subtag_id = $(this).data('subtag-id')
	get_offers()
});

$(document).on('keyup','#address_bar',function(e){
	if(e.which==13){
		latitude = $(this).val()
		longitude=""
		get_offers()
	}
})

$(document).on('click','#address_button',function(){
	latitude = $("#address_bar").val()
	longitude=""
	get_offers()
})

$(document).on('click','.subtag_button', function(){
	var header_offset = 0;
	if ($("#header_big").is(":visible")) {
		header_offset = $("header").height();
	} else {
		header_offset = $("#header_mobile").height();
	}
	$('html,body').animate({scrollTop: $("#grid").offset().top - header_offset},'slow');
	$('.subtag_button').removeClass('active')
	$(this).toggleClass('active')
})

$(document).on('click','.tag_button', function(){
	var id = $(this).data("tag-id")
	$("#tag_bar").fadeOut(200)
    $("#filter_box").animate({
        height: $("#subtag"+id).height() + $("#filter_box").height() - 55}, 300, function() {
        	$("#subtag"+id).fadeIn(200)
        	$("#filter_box").css("height", "auto")
    	});
});

$(document).on('click','.tag_close', function(){
	$(".subtag_bar").fadeOut(200)
	$("#tag_bar").fadeIn(200)
	$("#filter_box").animate({
        height: $("#filter_box").height() - $(this).parent().parent().height() + 55}, 300, function() {
        	$("#tag_bar").fadeIn(200)
        	$("#filter_box").css("height", "auto")
    	});
})

$(document).on('click','.get_offer_btn', function(){
	var button = $(this)
	$.ajax({
		type:'get',
		url:'user/get_offer/?offer_id='+$(this).data('offer-id'),
		success:function(){
			button.html('Delete Offer')
			button.removeClass("offer_btn get_offer_btn")
			button.addClass("offer_btn delete_offer_btn")
		},
	})
})

$(document).on('click','.delete_offer_btn', function(){
	var button = $(this)
	$.ajax({
		type:'get',
		url:'user/delete_offer/?offer_id='+$(this).data('offer-id'),
		success:function(){
			button.html('Get Offer')
			button.removeClass("offer_btn delete_offer_btn")
			button.addClass("offer_btn get_offer_btn")
		},
	})
})

$(document).on('click','#my_location',function(){
	geolocation()
})

function get_offers(){
	//alert("latitude:"+latitude+" longitude:"+longitude+" tag_id:"+tag_id+" subtag_id:"+subtag_id)
	$.ajax({
		type:'get',
		url:'offers/show/?latitude='+latitude+'&longitude='+longitude+'&tag_id='+tag_id+'&subtag_id='+subtag_id,
		success:function(data){
			$("#grid").html(data)
		}
	})
}

function set_position(position){
	$("#spinner").hide()
	latitude = position.coords.latitude
	longitude = position.coords.longitude
	get_offers()
}

