ActiveAdmin.register WheelUserPrize do
  menu parent: '转盘', label: '用户中奖情况'
  config.batch_actions = false
  actions :all, except: [:new, :edit, :create, :destroy]

  filter :wheel_prize
  filter :is_expensive
  filter :used
  filter :prize_type, as: :select, collection: AdminTrans::WHEEL_PRIZE_TYPES

  index do
    render 'index', context: self
  end

  member_action :use_prize, method: [:get, :post] do
    return if request.get?

    resource.update(used: true, used_time: Time.current, used_memo: params[:used_memo])
    redirect_to admin_wheel_user_prizes_url
  end
end
