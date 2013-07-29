class Snapme.Camera
  constructor: (@video, @canvas, onSuccess, onFailure) ->
    @onFailure = onFailure || @videoFailureCallback
    @onSuccess = onSuccess || @videoSuccessCallback
    @recording = false

  imageAsFile: =>
    @canvas.toDataURL('snap.png')

  recordVideo: =>
    navigator.getMedia(@videoConstraints,
      @onSuccess,
      @onFailure)
    @recording = true

  takeSnapshot: (callback) =>
    throw "Video must be recording to take a snapshot" unless @recording
    context = @canvas.getContext('2d')
    context.drawImage(@video, 0, 0, 300, 300);
    callback() if callback

  videoConstraints:
    video: true
    audio: false

  videoFailureCallback: (err) =>
    console.log("Error with video capture: " + err)

  videoSuccessCallback: (localMediaStream) =>
    @video.src = window.URL.createObjectURL(localMediaStream)
    @video.play()
