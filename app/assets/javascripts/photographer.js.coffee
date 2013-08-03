$ ->
  snapshooter = $('#snapshooter')

  if snapshooter.length
    snaps_allowed = ->
      snapshot.take()
      thirty_seconds = 30000
      setInterval(snapshot.take, thirty_seconds)

    snapshot = new Snapme.Snapshot(snapshooter, snaps_allowed)
