
class PostImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?|| Rails.env.test?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  def extension_allowlist
    %w[jpg jpeg gif png]
  end

  process :convert_to_webp

  def convert_to_webp
    manipulate! do |img|
      img.format "webp"
      img
    end
  end

  def filename
    super.chomp(File.extname(super)) + ".webp" if original_filename.present?
  end



  def default_url(*args)
    ActionController::Base.helpers.asset_path("post_placeholder.webp")
  end


  version :thumb do
    process resize_to_fill: [ 300, 200 ]
  end
end
