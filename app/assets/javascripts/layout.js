$(document).ajaxStart(function(){
  $('#spinner').show()
});

$(document).ajaxComplete(function(){
  $('#spinner').hide()
});

$(document).click(function(e) {
    var container = $('.dropdown_container')
    if (!container.is(e.target) && container.has(e.target).length === 0) {
        container.removeClass('open');
        $('.dropdown_items', this).fadeOut(300)
    }
})

$(document).mouseup(function (e){
    var container = $("#header_mobile")
    if (!container.is(e.target) 
        && container.has(e.target).length === 0) 
    {
        $("#mobile_menu").hide()
    }
})

$(document).ready(function(){

    $('.dropdown_container').click(function() {
        $('.dropdown_items', this).fadeToggle(300)
        $(this).toggleClass('open')
    });

    $('#sign_in').click(function() {
        $('#account_type_modal').fadeToggle(300)
        $(this).toggleClass('open')
    });

    $('#mobile_menu_ctn').click(function() {
        $('#mobile_menu', this).slideToggle(400)
    });
 
});

 //closes modal boxes
$(document).on('click','.modal .header .close', function(){
    $(this).parent().parent().parent().fadeOut(300)
});

$(document).on('click','.modal', function(e){
   if(e.target == this){ // only if the target itself has been clicked
       $(".modal").fadeOut("fast");
   }
});
