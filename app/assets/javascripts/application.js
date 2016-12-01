
//
//= require jquery
//= require jquery_ujs
//= require_tree .
$(document).ready(function(){

$('.button-collapse').sideNav({
      menuWidth: 300, // Default is 240
      edge: 'left', // Choose the horizontal origin
      closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
      draggable: true // Choose whether you can drag to open on touch screens
    }
  );

$('select').material_select();


$('.location_info').hide();

$('.parallax').parallax();
$('.carousel.carousel-slider').carousel({full_width: true});


})

$(document).ready(function(){
     $('.slider').slider({full_width: true});
   });
