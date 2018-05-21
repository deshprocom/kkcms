TRANS_TOPIC_STATUSES = Topic.statuses.keys.collect { |d| [I18n.t("status.#{d}"), d] }
ActiveAdmin.register Topic do
  menu priority: 2, label: '社交管理', parent: '社交管理'
  actions :all, except: [:new, :create, :edit, :update, :destroy]

  filter :title
  filter :body
  filter :user_id
  filter :created_at, as: :date_range

  index do
    render 'index', context: self
  end

  member_action :excellent, method: :post do
    resource.excellent!
    redirect_back fallback_location: admin_topics_url, notice: I18n.t('publish_notice')
  end

  member_action :unexcellent, method: :post do
    resource.unexcellent!
    redirect_back fallback_location: admin_topics_url, notice: I18n.t('unpublish_notice')
  end

  member_action :change_status, method: :put do
    resource.update(status: params[:status])
    render json: resource
  end
end
