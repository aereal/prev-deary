(function() {
  $(function() {
    var now;
    now = new Date();
    return $('time[data-relative-time]').each(function() {
      var $time, datetime, delta, relativeTime;
      $time = $(this);
      datetime = new Date($time.attr('datetime'));
      delta = (now - datetime) / 1000;
      relativeTime = (function() {
        switch (false) {
          case !(delta < 60):
            return "" + (Math.round(delta)) + " seconds ago";
          case !(delta < (60 * 60)):
            return "" + (Math.round(delta / 60)) + " minutes ago";
          case !(delta < (60 * 60 * 24)):
            return "" + (Math.round(delta / (60 * 60))) + " hours ago";
        }
      })();
      return $time.text(relativeTime);
    });
  });

}).call(this);
