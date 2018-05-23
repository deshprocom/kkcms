TRANS_TOPIC_STATUSES = Topic.statuses.keys.collect { |d| [I18n.t("status.#{d}"), d] }
ActiveAdmin.register Topic do
  menu priority: 2, label: '说说长帖', parent: '社交管理'
  actions :all, except: [:new, :create, :edit, :update, :destroy]

  filter :title
  filter :body
  filter :user_id
  filter :created_at, as: :date_range

  index do
    render 'index', context: self
  end

  show do
    render 'show'
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

  member_action :likes, method: :get do
    @page_title = "点赞列表 (#{resource.likes_count})"
    @like_by_users = resource.like_by_users.page(params[:page]).per(10)
  end
end
