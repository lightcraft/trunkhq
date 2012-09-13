$(function () {
  var location_updater = null;

  $('#sys_log_tabs a[data-toggle="tab"]').on('shown', function (e) {
    console.log(e.target) // activated tab
    e.preventDefault();
    $(this).tab('show');
    // $($(e.target).attr('href')).load(e.target.hash.replace('#','/'));
    if (location_updater != null) {
      clearTimeout(location_updater);
    }
    location_updater = setInterval(function () {
      $($(e.target).attr('href')).load(e.target.hash.replace('#', '/'));
    }, 1000);
  });


  $('#sys_log_tabs a:first').tab('show');
  $('#stop_monitors').live('click', function(){
    if (location_updater != null) {
      clearTimeout(location_updater);
    }
  });
});