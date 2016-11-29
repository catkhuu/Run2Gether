
$(function() {
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
      hideButtons();
    }).fail(function(jqXHR, TextStatus, status) {
      var errors = $.parseJSON(jqXHR.responseText)
      $.each(errors, function(index, value) {
        $('#errors').append('<li>' + value + '</li>')
      });
    })
  });

  $('#rundown_container').on('click', '#start-new-run-btn', function(event) {
    event.preventDefault();
    var $createRunBtn = $(this);
    var route = $createRunBtn.attr('href');
    $.ajax({
      url: route,
      method: 'GET'
    }).done(function(response) {
     $('div.run-form').append(response);
     hideButtons();
     enableMaterialize();
    })
  });

$('div.run-form').on('click','#create-run-btn',function(event){
  event.preventDefault();

  $(this).parent().remove();
  var data = $(this).parent().serialize();
  var url = $(this).parent().attr('action');
  var method = $(this).parent().attr('method');

  $.ajax({
    url: url,
    method: method,
    data: data
  }).done(function(response){
    $('.upcoming-table').replaceWith(response);
    showButtons();
  }).fail(function(jqXHR, TextStatus, status) {
      var errors = $.parseJSON(jqXHR.responseText)
      $.each(errors, function(index, value) {
        $('#errors').append('<li>' + value + '</li>')
      });
    })

})

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
      $('.run-form').append(response);
    }).fail(function(jqXHR, TextStatus, status) {
      var errors = $.parseJSON(jqXHR.responseText)
      $.each(errors, function(index, value) {
        $('#errors').append('<li>' + value + '</li>')
      });
    })
  });
// accept run button when match is found
  $('.my-rundown-container').on('click', '.my-accept-run-btn', function(event) {
    event.preventDefault();

    var $acceptBtn = $(this)
    var route = $acceptBtn.attr('href');
    // var runId = $acceptBtn.attr('data');
    // var data = { run_id: runId }
    var stringData = $acceptBtn.attr('id');
    var data = parseInt(stringData)
    $(this).parent().parent().parent().parent().hide();
    $.ajax({
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: route,
      method: 'PUT', //POST for now, but will be a PATCH
      data: {'companion_id': data}
    }).done(function(response) {
      $('.upcoming-table').replaceWith(response);
    })
  });
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
    });
  });

});



function hideButtons() {
  $('#start-new-run-btn').hide();
  $('#search-for-run-btn').hide();
}
function showButtons() {
  $('#start-new-run-btn').show();
  $('#search-for-run-btn').show();
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
};
