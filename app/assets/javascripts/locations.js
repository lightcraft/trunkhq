$(function () {
  var location_updater = null;

  function tab_updater(el) {
    var tab = el;
    var id = $(tab.target).attr('href');
    var path = id.replace(/[\_#]/gi, '/');
    if (window.isActive != false) { //check if window is active and update channel states
      $(id).load(path, function () {
        // clean mouse over old tolltips
        $('.tooltip').hide();

        if (location_updater != null) {
          clearTimeout(location_updater);
        }
        location_updater = setTimeout(function () {
          tab_updater(tab);
        }, 20000);   // 20 second

        $('[rel="tooltip"]').tooltip();
      });
    } else {
      $(id).html('Monitoring stopped! Please refresh page if you want see activity.');
    }
  }

  $('#locations a[data-toggle="tab"]').on('shown', function (e) {
    tab_updater(e);
  });

  //autoload first tab after open this page
  if ($('#locations li.active a').get(0) == undefined) {
    $('#locations li:eq(0) a').tab('show');
  } else {
    $('#locations li.active a').tab('show');
  }

});
