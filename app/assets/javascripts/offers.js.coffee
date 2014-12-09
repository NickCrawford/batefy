# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$.get("ajax.php?action=getresults", function(html){
     $("#somediv").append(html);
     $('#busy').delay(1500).fadeOut(700);
});​​​