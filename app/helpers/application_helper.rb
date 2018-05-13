module ApplicationHelper
  def img_link_to_show(resource, preview = nil)
    image = preview || resource.preview_logo
    # link_to resource.logo.url ? image_tag(resource.preview_logo, height: 150) : '', resource_path(resource)
    link_to image_tag(image, height: 150), resource_path(resource)
  end

  def hotel_sidebar_generator(context)
    context.instance_eval do
      ul do
        li link_to '酒店详情', admin_hotel_path(hotel)
        li link_to '图片管理', admin_hotel_images_path(hotel)
      end
    end
  end

  def hotel_publish_link(hotel)
    if hotel.published?
      link_to I18n.t('unpublish'), unpublish_admin_hotel_path(hotel), method: :post
    else
      link_to I18n.t('publish'), publish_admin_hotel_path(hotel), method: :post
    end
  end

  def info_publish_link(info)
    if info.published?
      link_to I18n.t('unpublish'), unpublish_admin_info_path(info), method: :post
    else
      link_to I18n.t('publish'), publish_admin_info_path(info), method: :post
    end
  end

  def info_sticky_link(info)
    if info.stickied?
      link_to I18n.t('unsticky'), unsticky_admin_info_path(info), method: :post
    else
      link_to I18n.t('sticky'), sticky_admin_info_path(info), method: :post
    end
  end
end
