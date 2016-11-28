function initMap() {
  var default_position = {lat: $('.mid').data('midpoint')[0], lng: $('.mid').data('midpoint')[1]};
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: default_position
  });
  var marker = new google.maps.Marker({
    position: default_position,
    map: map
  });
}

// $( document ).ready(function(){
//   var middle = $('.mid').data('midpoint')
//   $('#rundown_container').on('click', 'accept', function(event){
//     event.preventDefault();
//     var route = $(this).closest('SOMETHING')
//
//
//
//
//   })
//   $.ajax({
//     url: route,
//     method: 'GET'
//   }).done(function(response) {
//       alert(response);
//   })
// })
