module ApplicationHelper
  def img_link_to_show(resource)
    link_to resource.logo.url ? image_tag(resource.preview_logo, height: 150) : '', resource_path(resource)
  end
end
