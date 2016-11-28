$(function() {
  $('#new-run-container').on('click', '#search-for-run-btn', function(event) {
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
      debugger;
      alert(response); //Matt is handling the response from server along with partial
      $('.run-form').append(response);
    }).fail(function(jqXHR, TextStatus, status) {
      var errors = $.parseJSON(jqXHR.responseText)
      $.each(errors, function(index, value) {
        $('#errors').append('<li>' + value + '</li>')
      });
    })
  })
});

function hideButtons() {
  $('#start-new-run-btn').hide();
  $('#search-for-run-btn').hide();
}

function enableMaterialize() {
  $('.datepicker').pickadate({
   selectMonths: true,
   selectYears: 15
  });
  $('select').material_select();
}
