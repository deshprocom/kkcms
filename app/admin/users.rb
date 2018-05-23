ActiveAdmin.register User do
  menu priority: 1, parent: '用户管理', label: 'app用户'

  actions :all, except: [:new, :destroy, :edit]

  permit_params :mark

  filter :user_name
  filter :nick_name
  filter :mobile
  filter :email
  filter :reg_date
  filter :last_visit

  index do
    render 'index', context: self
  end

  sidebar :'数量统计', only: :index do
    ul do
      li "用户总数：#{User.count}个"
    end
  end

  member_action :profile, method: :get do; end

  member_action :followers, method: :get do
    @page_title = "粉丝列表(共计#{resource.followers_count})"
    @followers = resource.follow_by_users.page(params[:page])
  end

  member_action :followings, method: :get do
    @page_title = "关注列表(共计#{resource.following_count})"
    @followings = resource.follow_users.page(params[:page])
  end
end
