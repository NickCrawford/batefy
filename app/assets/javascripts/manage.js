$(document).ready(function(){


	$(".new_toggle").click(function(){
		var id = $(this).data("id")
		if ($(this).hasClass( "active" )) {//close
			$("#"+id).slideToggle(300)
			setTimeout(function () {
    			$(".new_toggle").removeClass('active').html('<i class="fa fa-plus "></i>')
			}, 300);
		} else {//open
			$("#"+id).delay(200).slideToggle(300)
			$(this).addClass("active").html('<p>New Offer</p><i class="fa fa-times fa-lg"></i>')
		}
	});

	$(".day_toggle, .close").click(function(){
		var id = $(this).data("id")
		$("#"+id).fadeToggle(300)
	});


	$("#month0").css("display","block")

	$(".change_month").click(function(){
		var id = $(this).data("id")
		if (id >= 0 && id+1<=6 ) {
			$(".month").css("display","none")
			$("#month"+id).show()
		}
	});

});
