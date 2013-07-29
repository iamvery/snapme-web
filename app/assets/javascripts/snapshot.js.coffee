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
    data = new FormData()

    data.append('snapshot', image)
    $.ajax
      url: '/snapshot'
      cache: false,
      contentType: false,
      processData: false,
      type: 'POST'
      data:
        data
