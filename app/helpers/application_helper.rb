module ApplicationHelper
  def img_link_to_show(resource)
    link_to resource.logo.url ? image_tag(resource.preview_logo, height: 150) : '', resource_path(resource)
  end

  def hotel_publish_link(hotel)
    if hotel.published?
      link_to I18n.t('unpublish'), unpublish_admin_hotel_path(hotel), method: :post
    else
      link_to I18n.t('publish'), publish_admin_hotel_path(hotel), method: :post
    end
  end
end
