Erp::Contacts::ContactUploader.class_eval do
  version :logo_thumb do
    process :resize_and_pad => [278, 50, "", "Center"]
  end
end