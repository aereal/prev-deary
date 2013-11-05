$(function () {
  var now = new Date();
  var $times = $('time[data-relative-time]');
  $times.each(function () {
    var $self = $(this);
    var d = new Date($self.attr('datetime'));
    var delta = (now - d) / 1000; // milliseconds -> seconds
    if (delta < 60) {
      $self.text(Math.round(delta) + ' seconds ago');
    } else if (delta < (60 * 60)) {
      $self.text(Math.round(delta / 60) + ' minutes ago');
    } else if (delta < (60 * 60 * 24)) {
      $self.text(Math.round(delta / (60 * 60)) + ' hours ago');
    }
  });
});
