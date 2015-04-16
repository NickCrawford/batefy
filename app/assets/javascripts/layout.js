$(document).ajaxStart(function(){
  $('#spinner').show()
});

$(document).ajaxComplete(function(){
  $('#spinner').hide()
});

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

$(document).mouseup(function (e)
{
    var container = $("#header_mobile")

    if (!container.is(e.target) 
        && container.has(e.target).length === 0) 
    {
        $("#mobile_menu").hide()
    }
});

 //closes modal boxes
$(document).on('click','.modal .header .close', function(){
    $(this).parent().parent().parent().fadeOut(300)
});

$(document).on('click','.modal', function(){
   
});