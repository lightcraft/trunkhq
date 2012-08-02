$(function () {
  var location_updater = null;

  function tab_updater(el) {
    var tab = el;
    var id = $(tab.target).attr('href');
    var path = id.replace(/[\_#]/gi, '/');
    $(id).load(path, function () {
      if (location_updater != null) {
        clearTimeout(location_updater);
      }
      location_updater = setTimeout(function () { tab_updater(el); }, 20000);   // 20 secund
    });
  }

  $('a[data-toggle="tab"]').on('shown', function (e) {
    tab_updater(e);
  });

  //autoload first tab after open this page
  $('#locations li:eq(0) a').tab('show');
});
