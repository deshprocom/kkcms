ActiveAdmin.register Comment do
  config.breadcrumb = false
  actions :all, except: [:new]

  filter :user_nick_name_or_replies_user_nick_name, as: :string
  filter :body_or_replies_body, as: :string
  filter :excellent
  filter :created_at_replies_created_at, as: :date_range

  index do
    render 'index'
  end

  member_action :excellent, method: :post do
    resource.excellent!
    redirect_back fallback_location: admin_comments_url, notice: I18n.t('publish_notice')
  end

  member_action :unexcellent, method: :post do
    resource.unexcellent!
    redirect_back fallback_location: admin_comments_url, notice: I18n.t('unpublish_notice')
  end
end
