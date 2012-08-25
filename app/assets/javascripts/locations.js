$(function () {
  var location_updater = null;

  function tab_updater(el) {
    var tab = el;
    var id = $(tab.target).attr('href');
    var path = id.replace(/[\_#]/gi, '/');
    if (window.isActive != false) { //check if window is active and update channel states
      $(id).load(path, function () {
        if (location_updater != null) {
          clearTimeout(location_updater);
        }
        location_updater = setTimeout(function () {
          tab_updater(tab);
        }, 5000);   // 20 secund
      });
    }else{
      $(id).html('Monitoring stopped!');
    }
  }

  $('#locations a[data-toggle="tab"]').on('shown', function (e) {
    tab_updater(e);
  });

  //autoload first tab after open this page
  $('#locations li:eq(0) a').tab('show');
});
