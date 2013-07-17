# encoding: utf-8

class SnapshotUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    "#{Time.now.to_s(:number)}.#{file.extension}"
  end
end
