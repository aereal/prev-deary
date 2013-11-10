$ ->
  now = new Date()
  $('time[data-relative-time]').each ->
    $time = $(@)
    datetime = new Date($time.attr('datetime'))
    delta = (now - datetime) / 1000 # milliseconds -> seconds

    minute = 60
    hour = minute * 60
    day = hour * 24
    week = day * 7
    month = day * 30
    year = day * 365
    relativeTime =
      switch
        when delta < minute
          "#{Math.round(delta)} seconds ago"
        when delta < hour
          "#{Math.round(delta / minute)} minutes ago"
        when delta < day
          "#{Math.round(delta / hour)} hours ago"
        when delta < week
          "#{Math.round(delta / day)} days ago"
        when delta < month
          "#{Math.round delta / week} weeks ago"
        when delta < year
          "#{Math.round delta / month} months ago"
    $time.text(relativeTime)
