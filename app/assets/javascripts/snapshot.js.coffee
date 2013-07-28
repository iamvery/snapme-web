class Snapme.Snapshot
  constructor: (videoSelector, canvasSelector) ->
    @video = $(videoSelector)[0]
    @canvas = $(canvasSelector)[0]
    @camera = new Snapme.Camera(@video, @canvas)
    @camera.recordVideo()

  take: (callback) ->
    @camera.takeSnapshot()

  takeEvery: (interval, callback) ->
    @camera.takeSnapshot()
    fun = callback || @uploadImage
    window.setInterval(@camera.takeSnapshot, interval, fun);

  uploadImage: =>
    image = @camera.imageAsFile()
    $.ajax
      url: '/snapshot'
      type: 'POST'
      data:
        snapshot: image
