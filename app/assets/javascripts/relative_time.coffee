$ ->
  now = new Date()
  $('time[data-relative-time]').each ->
    $time = $(@)
    datetime = new Date($time.attr('datetime'))
    delta = (now - datetime) / 1000 # milliseconds -> seconds
    relativeTime =
      switch
        when delta < 60
          "#{Math.round(delta)} seconds ago"
        when delta < (60 * 60)
          "#{Math.round(delta / 60)} minutes ago"
        when delta < (60 * 60 * 24)
          "#{Math.round(delta / (60 * 60))} hours ago"
    $time.text(relativeTime)
