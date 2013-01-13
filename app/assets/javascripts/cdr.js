$(window).bind('changeDate', function(ev) {
  window.location = '/cdr/index?date_filter='+$(ev.target).data('date');
});


