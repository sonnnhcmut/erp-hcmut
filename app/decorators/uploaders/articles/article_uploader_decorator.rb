Erp::Articles::ArticleUploader.class_eval do
  version :post_thumb do
    process resize_to_fill: [360, 240]
  end
  
  version :newest_thumb do
    process resize_to_fill: [330, 225]
  end
  
  version :single_thumb do
    process resize_to_fill: [750, 0]
  end
end