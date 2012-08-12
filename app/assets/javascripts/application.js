//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

$(function () {
  $('[rel="tooltip"]').tooltip();

  $('body').ajaxComplete(function () {
    $('body').attr('style', 'cursor:default');
  }).bind("ajaxSend", function () {
        $('body').attr('style', 'cursor:progress');
      });
});
