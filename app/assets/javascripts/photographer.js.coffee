$ ->
  video = '#video'
  canvas = '#canvas'
  snapshooter = new Snapme.Snapshot(video, canvas)

  snapshooter.takeEvery(30000)
