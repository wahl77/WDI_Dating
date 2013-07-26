class ImageUploader < FileUploader
  include CarrierWave::RMagick

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  version :thumb do
    process :resize_to_fit => [200, 200]
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
     "assets/images/default.jpg"
  end
   
end
