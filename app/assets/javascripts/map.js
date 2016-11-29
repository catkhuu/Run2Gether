function initMap() {
  var default_position = {lat: $('.mid').data('meetingpoint')[0], lng: $('.mid').data('meetingpoint')[1]};
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: default_position
  });
  var marker = new google.maps.Marker({
    position: default_position,
    map: map
  });
}
