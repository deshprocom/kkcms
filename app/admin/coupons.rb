ActiveAdmin.register Coupon do
  menu priority: 3, parent: '优惠券', label: '列表'
  config.clear_action_items!
  config.sort_order = 'receive_time_desc'

  filter :coupon_number
  filter :user_id

  index do
    render 'index', context: self
  end
end
