require 'spec_helper'
require 'carrierwave/test/matchers'

describe SnapshotUploader do
  include CarrierWave::Test::Matchers

  let(:file)     { File.open(file_path) }
  let(:file_path){ Rails.root.join('spec', 'fixtures', 'image.png') }
  let(:user)     { User.new }

  subject(:uploader){ described_class.new(user) }

  before do
    described_class.enable_processing = true
    uploader.store!(file)
  end

  after do
    described_class.enable_processing = false
    uploader.remove!
  end

  it 'is within the maximum dimensions' do
    expect(uploader).to be_no_larger_than(described_class::MAX_WIDTH, described_class::MAX_HEIGHT)
  end

  it 'is converted to jpg' do
    expect(uploader.file.extension).to eq('jpg')
  end

  it 'is converted to grayscale' do
    pending 'Is there any way to test this?'
  end
end
