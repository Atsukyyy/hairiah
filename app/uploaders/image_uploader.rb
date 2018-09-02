class ImageUploader < CarrierWave::Uploader::Base

  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave

  # process :convert => 'png'
  # process :tags => ['image']
  #
  process :resize_to_limit => [600, 600]

  version :standard do
    process :resize_to_fill => [500, 500, :north]
  end

  version :thumbnail do
    process :resize_to_fit => [500, 500]
  end

  def public_id
    return model.id
  end

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog


  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end


end
