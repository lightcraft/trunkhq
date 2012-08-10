$(function () {
  //autoload first tab after open this page
  $('.operators li:eq(0)').tab('show');
  $('.operators li:eq(0) a').first().click();

});
