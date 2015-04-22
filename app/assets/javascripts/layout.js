$(document).ready(function(){
    var timezone = jstz.determine()
    console.log(timezone.name())
    console.log(getCookie("time_zone"))
    if (getCookie("time_zone") != encodeURIComponent(timezone.name())){
        set_cookie("time_zone",encodeURIComponent(timezone.name(),365,"localhost:3000/")
        location.reload()
    }
});

$(document).ajaxStart(function(){
  $('#spinner').show()
});

$(document).ajaxComplete(function(){
  $('#spinner').hide()
});

$(document).on('click',function(e) {
    var container = $('.dropdown_container')
    if (!container.is(e.target) && container.has(e.target).length === 0) {
        container.removeClass('open');
        $('.dropdown_items', this).fadeOut(300)
    }
})

$(document).on('click','.dropdown_container',function(){
    $('.dropdown_items', this).fadeToggle(300)
    $(this).toggleClass('open')
})

$(document).on('mouseup',function (e){
    var container = $("#header_mobile")
    if (!container.is(e.target) 
        && container.has(e.target).length === 0) 
    {
        $("#mobile_menu").hide()
    }
})

$(document).on('click','#mobile_menu_ctn',function() {
    $('#mobile_menu', this).slideToggle(400)
})

//closes modal boxes
$(document).on('click','.modal .header .close', function(){
    $(this).parent().parent().parent().fadeOut(300)
});

$(document).on('click','.modal', function(){
   
});

function getCookie(name) {
  var value = "; " + document.cookie;
  var parts = value.split("; " + name + "=");
  if (parts.length == 2) return parts.pop().split(";").shift();
}

function set_cookie ( cookie_name, cookie_value, lifespan_in_days, valid_domain )
{
  var domain_string = valid_domain ? ("; domain=" + valid_domain) : '' ;
  document.cookie = cookie_name + "=" + encodeURIComponent( cookie_value ) +
      "; max-age=" + 60 * 60 * 24 * lifespan_in_days +
      "; path=/" + domain_string ;
}