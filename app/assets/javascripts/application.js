//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
//= require_self

$(function () {
  $('[rel="tooltip"]').tooltip();
  $('input, textarea').placeholder();

  $('body').ajaxComplete(function () {
    $('body').attr('style', 'cursor:default');
  }).bind("ajaxSend", function () {
        $('body').attr('style', 'cursor:progress');
      });


  window.isActive = true;
  $(window).focus(function () {
    this.isActive = true;
  });
  $(window).blur(function () {
    this.isActive = false;
  });
  $('.datepicker').datepicker({ format:'yyyy-mm-dd'}).on('changeDate', function(ev){
    $(this).datepicker('hide');
  });
});
