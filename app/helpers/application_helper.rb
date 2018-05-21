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

  def avatar(src, options = {})
    html_options = { class: 'img-circle', size: 60 }.merge(options)
    image_tag(src, html_options) if src.present?
  end

  def topic_excellent_link(topic)
    if topic.excellent?
      link_to I18n.t('unexcellent'), unexcellent_admin_topic_path(topic), method: :post
    else
      link_to I18n.t('excellent'), excellent_admin_topic_path(topic), method: :post
    end
  end
end
