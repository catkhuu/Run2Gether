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
      $('.run-form').append(response);
    }).fail(function(jqXHR, TextStatus, status) {
      var errors = $.parseJSON(jqXHR.responseText)
      $.each(errors, function(index, value) {
        $('#errors').append('<li>' + value + '</li>')
      });
    })
  });

  $('#rundown_container').on('click', '.accept-run-btn', function(event) {
    event.preventDefault();
    var $acceptBtn = $(this).find('a');
    var route = $acceptBtn.attr('href');
    // var runId = $acceptBtn.attr('data');
    // var data = { run_id: runId }
    $.ajax({
      url: route,
      method: 'PUT'
    }).done(function(response) {
      alert(response);
      $('div.upcoming-runs-table').replaceWith(response);
    })

  })
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
