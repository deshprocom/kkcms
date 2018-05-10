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

  def hotel_sidebar_generator(context)
    context.instance_eval do
      ul do
        li link_to '酒店详情', admin_hotel_path(hotel)
        li link_to '图片管理', admin_hotel_images_path(hotel)
      end
    end
  end
end
