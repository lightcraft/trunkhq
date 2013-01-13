$(window).bind('changeDate', function(ev) {
   if($(ev.target).attr('id') == 'cdr_callendar'){
     //only for CDR
     window.location = '/cdr/index?date_filter='+$(ev.target).data('date')
   }
});


