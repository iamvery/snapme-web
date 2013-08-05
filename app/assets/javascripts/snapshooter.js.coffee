window.Snapme or= {}

class Snapme.Snapshooter
  constructor: (camera, @onDenied) ->
    feed    = camera.find('video.feed').get(0)
    frame   = camera.find('canvas.frame').get(0)
    @camera = new Snapme.Camera(feed, frame, @cameraReady, @onDenied)

  cameraReady: =>
    @takeRepeatedly()

  start: =>
    if @camera.recording
      @takeRepeatedly()
    else
      @camera.turnOn()

  stop: =>
    @camera.turnOff()
    clearInterval(@interval_id)

  takeRepeatedly: =>
    @take()
    @interval_id = setInterval(@take, 30000)

  take: =>
    @camera.snap(@uploadImage)

  uploadImage: =>
    image = @camera.image()
    data = new FormData()
    data.append('snapshot', image)

    $.ajax
      url: '/snapshot'
      cache: false,
      contentType: false,
      processData: false,
      type: 'POST'
      data: data
