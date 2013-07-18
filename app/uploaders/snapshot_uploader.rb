# encoding: utf-8

class SnapshotUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  MAX_WIDTH = MAX_HEIGHT = 300

  storage :file
  process :convert_to_grayscale
  process resize_to_fit: [MAX_WIDTH, MAX_HEIGHT]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    "#{Time.now.to_s(:number)}.#{file.extension}"
  end

  private

  def convert_to_grayscale
    manipulate! do |image|
      image.colorspace('Gray')
      image = yield(image) if block_given?
      image
    end
  end
end
