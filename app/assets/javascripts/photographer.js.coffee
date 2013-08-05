$ ->
  media_denied = ->
    alert('denied')

  snapshooter = new Snapme.Snapshooter(
    $('#snapshooter'),
    media_denied,
  )

  $('#photographer_toggle').change ->
    toggle = $(this)
    if toggle.is(':checked')
      snapshooter.start()
    else
      snapshooter.stop()
