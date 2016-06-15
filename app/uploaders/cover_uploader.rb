# encoding: utf-8

class CoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    file_name = [version_name, 'default.jpg'].compact.join('_')
    ActionController::Base
      .helpers
      .asset_path('fallback/' + file_name)
  end

  process scale: [400, 400]

  version :thumb do
    process resize_to_fit: [200, 200]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
