class ShopImageUploader < BaseUploader
  process :crop

  def store_dir
    "uploads/shop/#{model.imageable_type}"
  end
end
