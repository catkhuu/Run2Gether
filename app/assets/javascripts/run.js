$(function(){
  // opens form for search button
$('#rundown_container').on('click', '#search-for-run-btn', function(event) {
  event.preventDefault();
  var $searchBtn = $(this);
  var route = $searchBtn.attr('href');
  $.ajax({
    url: route,
    method: 'GET'
  }).done(function(response) {
    $('div.run-form').append(response);
    enableMaterialize();
    hideUpcoming();
    hideMatchCard();
    hideButtons();
    hideMap();
    showMap();
  })
});

// opens form for run creation
$('#rundown_container').on('click', '#start-new-run-btn', function(event) {
  event.preventDefault();
  $('.upcoming-runs-table').hide();
  var $createRunBtn = $(this);
  var route = $createRunBtn.attr('href');
  $.ajax({
    url: route,
    method: 'GET'
  }).done(function(response) {
   $('div.run-form').append(response);
   enableMaterialize();
   hideMatchCard();
    hideUpcoming();
    hideButtons();
    showMap();
  });
});
// creates actual run object
$('div.run-form').on('click','#create-run-btn',function(event){
  event.preventDefault();
  var $form = $('#new-run-form').find('form');
  $('#new-run-form').remove();
  var data = $form.serialize();
  var url = $form.attr('action');
  var method = $form.attr('method');
  $.ajax({
    url:url,
    method: method,
    data: data
  }).done(function(response){
    $('.upcoming-table').replaceWith(response);
    $('.upcoming-runs-table').show();
     enableMaterialize();
     removeNewRunForm();
      showUpcoming();
      showButtons();
  }).fail(function(jqXHR, TextStatus, status) {
      var errors = $.parseJSON(jqXHR.responseText);
      $.each(errors, function(index, value) {
        $('#errors').append('<li>' + value + '</li>');
      });
    });
});
//initiaiteas db search to find partner
$('#rundown_container').on('click', '#find-partner-btn', function(event) {
  event.preventDefault();
  $('.new-search-form').hide();
  var $searchForm = $(this);
  var data = $searchForm.parent().serialize();
  var route = $searchForm.parent().attr('action');
  var method = $searchForm.parent().attr('method');
  $.ajax({
    url: route,
    type: method,
    data: data
  }).done(function(response) {
//Matt is handling the response from server along with partial
    showButtons();
    hideUpcoming();
    hideMatchCard();
    $('.run-form').append(response);
  }).fail(function(response) {
    showButtons();
    $('#errors').append('<li>' + response.statusText + '</li>');
  });
});
// accept run button when match is found
$('.my-rundown-container').on('click','.my-accept-run-btn',function(event){
  event.preventDefault();
  var $acceptBtn = $(this);
  var route = $acceptBtn.attr('href');
  var stringData = $acceptBtn.attr('id');
  var data = parseInt(stringData);
  $(this).parent().parent().parent().parent().hide();
  $.ajax({beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
  url: route,
  method: 'PUT',
  data: {'companion_id': data}
}).done(function(response) {
  hideMatchCard();
  showUpcoming();
  $('.upcoming-table').replaceWith(response);
}).fail(function(jqXHR, TextStatus, status) {
  var errors = $.parseJSON(jqXHR.responseText);
  $.each(errors, function(index, value) {
    $('#errors').append('<li>' + value + '</li>');
  });
});
});
//clickable-row ajaxification
$(document).on('click','.clickable-row',function(event) {
  event.preventDefault();
  var runData = $(this).attr('id');
  $.ajax({
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    url: 'updatemap',
    method: 'POST',
    data: {'run_id': runData}
  }).done(function(response) {
    onRefresh(response);
    showLocationInfo();
  }).fail(function(jqXHR, TextStatus, status) {
    var errors = $.parseJSON(jqXHR.responseText);
    $.each(errors, function(index, value) {
      $('#errors').append('<li>' + value + '</li>');
    });
});

});
//helper function
function hideMap(){
  $('.map-container').hide();
}
function showMap(){
  $('.map-container').show();
}
function hideButtons() {
  $('#start-new-run-btn').hide();
  $('#search-for-run-btn').hide();
}
function showButtons() {
  $('#start-new-run-btn').show();
  $('#search-for-run-btn').show();
}
function hideRundown () {
  $('div.my-rundown-container').hide();
}
function showRundown () {
  $('div.my-rundown-container').show();
}
function hideUpcoming(){
  $('.upcoming-runs-table').hide();
  $(".past-run-table").hide();

}
function showUpcoming(){
  $('.upcoming-runs-table').show();
  $(".past-run-table").show();
}

function hideMatchCard(){
  $('.match-card').hide();
}
function removeNewRunForm(){
  $('#new-run-form').remove();
}
function showLocationInfo(){
  $('.location_info').show();
  $('.home_info').hide();
}
function enableMaterialize() {
  $('.datepicker').pickadate({
   selectMonths: true,
   selectYears: 15
  });
  $('select').material_select();
}
function onRefresh(position) {
   lat = position[0];
   lon = position[1];

   var default_position = {lat: lat, lng: lon};
   var map = new google.maps.Map(document.getElementById('map'), {
     zoom: 16,
     center: default_position
   });
   var marker = new google.maps.Marker({
     position: default_position,
     map: map
   });
}
// end of function
});
