#= require spec_helper
#= require camera

describe 'Snapme.Camera', ->
  beforeEach ->
    @context = { drawImage:  sinon.stub() }
    @feed    = { pause:      sinon.stub() }
    @frame   = { getContext: sinon.stub().returns(@context) }
    @camera  = new Snapme.Camera(@feed, @frame)

  describe '#turnOn', ->
    it 'requests access to media', ->
      navigator.getMedia = sinon.spy()

      @camera.turnOn()

      expect(navigator.getMedia).to.have.been
        .calledWith(
          @camera.videoConstraints,
          @camera.userMediaAllowed,
          @camera.onDenied,
        )

  describe '#turnOff', ->
    beforeEach ->
      @mediaStream = { stop: sinon.stub() }
      @camera.localMediaStream = @mediaStream

    it 'pauses the feed', ->
      @feed.pause = sinon.spy()
      @camera.turnOff()
      expect(@feed.pause).to.have.been.called

    it 'stops the media stream', ->
      @mediaStream.stop = sinon.spy()
      @camera.turnOff()
      expect(@mediaStream.stop).to.have.been.called

    it 'is no longer recording', ->
      @camera.recording = true
      @camera.turnOff()
      expect(@camera.recording).to.eq(false)

  describe '#snap', ->
    beforeEach ->
      @camera.recording = true

    it 'throws an error if not recording', ->
      @camera.recording = false
      expect(@camera.snap).to.throw(/must be recording/)

    it 'draws image', ->
      @context.drawImage = sinon.spy()

      @camera.snap()

      expect(@context.drawImage).to.have.been
        .calledWith(@feed, 0, 0)

    it 'calls callback if given', ->
      callback = sinon.spy()

      @camera.snap(callback)

      expect(callback).to.have.been.called

  describe '#userMediaAllowed', ->
    beforeEach ->
      @source      = {}
      sinon.stub(URL, 'createObjectURL').returns(@source)
      @feed.play = sinon.stub()

    afterEach ->
      URL.createObjectURL.restore()

    it "sets the feed's source", ->
      @camera.userMediaAllowed()
      expect(@feed.src).to.eq(@source)

    it 'plays the feed', ->
      @feed.play = sinon.spy()
      @camera.userMediaAllowed()
      expect(@feed.play).to.have.been.called

    it 'calls camera ready callback after 100ms if defined', (done) ->
      @camera.readyCallback = done
      @camera.userMediaAllowed()
