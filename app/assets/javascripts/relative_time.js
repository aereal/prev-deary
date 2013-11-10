(function() {
  $(function() {
    var now;
    now = new Date();
    return $('time[data-relative-time]').each(function() {
      var $time, datetime, day, delta, hour, minute, month, relativeTime, week, year;
      $time = $(this);
      datetime = new Date($time.attr('datetime'));
      delta = (now - datetime) / 1000;
      minute = 60;
      hour = minute * 60;
      day = hour * 24;
      week = day * 7;
      month = day * 30;
      year = day * 365;
      relativeTime = (function() {
        switch (false) {
          case !(delta < minute):
            return "" + (Math.round(delta)) + " seconds ago";
          case !(delta < hour):
            return "" + (Math.round(delta / minute)) + " minutes ago";
          case !(delta < day):
            return "" + (Math.round(delta / hour)) + " hours ago";
          case !(delta < week):
            return "" + (Math.round(delta / day)) + " days ago";
          case !(delta < month):
            return "" + (Math.round(delta / week)) + " weeks ago";
          case !(delta < year):
            return "" + (Math.round(delta / month)) + " months ago";
        }
      })();
      return $time.text(relativeTime);
    });
  });

}).call(this);
