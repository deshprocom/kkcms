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

  member_action :profile, method: [:get] do; end
end
