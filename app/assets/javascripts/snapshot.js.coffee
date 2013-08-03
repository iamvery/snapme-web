class Snapme.Snapshot
  constructor: (camera, onAllowed, onDenied) ->
    feed    = camera.find('video.feed').get(0)
    frame   = camera.find('canvas.frame').get(0)
    @camera = new Snapme.Camera(feed, frame, onAllowed, onDenied)
    @camera.turnOn()

  take: =>
    @camera.takeSnapshot(@uploadImage)

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
