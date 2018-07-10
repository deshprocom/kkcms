ActiveAdmin.register User do
  menu priority: 1, parent: '用户管理', label: 'app用户'

  actions :all, except: [:destroy, :edit]

  permit_params :mark, :nick_name, :email, :password

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

  form partial: 'form'

  controller do
    def scoped_collection
      User.includes(:counter)
    end

    def create
      email = user_params[:email]
      password = user_params[:password]
      if !UserValidator.email_valid?(email) || password.blank?
        return redirect_back fallback_location: admin_users_url, notice: '用户创建失败'
      end
      password_md5 = ::Digest::MD5.hexdigest(password)
      User.create_by_email(email, password_md5)
      redirect_back fallback_location: admin_users_url, notice: '用户创建成功'
    end

    def user_params
      params.require(:user).permit(:email,
                                   :password)
    end
  end

  member_action :profile, method: :get

  member_action :followers, method: :get do
    @page_title = "粉丝列表(共计#{resource.followers_count})"
    @followers = resource.follow_by_users.page(params[:page])
  end

  member_action :followings, method: :get do
    @page_title = "关注列表(共计#{resource.following_count})"
    @followings = resource.follow_users.page(params[:page])
  end

  member_action :block, method: [:post] do
    resource.update(blocked: true, blocked_at: Time.zone.now)
    render 'update_success'
  end

  member_action :unblock, method: [:post] do
    resource.update(blocked: false, blocked_at: Time.zone.now)
    render 'update_success'
  end

  member_action :silence_user, method: [:get, :post] do
    return render :silence unless request.post?
    resource.silenced!(params[:silence_reason], params[:silence_till])
    render 'update_success'
  end

  collection_action :search_user_modal, method: :get do
    render 'search_user_modal'
  end

  action_item :invite_awards, only: :index do
    link_to '分销奖励', admin_invite_awards_path
  end
end
