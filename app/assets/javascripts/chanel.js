$(function () {
  //autoload first tab after open this page
  $('.operators li:eq(0)').tab('show');
  $('.operators li:eq(0) a').first().click();
  //hide operators setting when checked SoftPhone checkbox
  $('#channel_sip_attributes_context').live('click', function(){$('.channel_form .operators').toggle();});
});
