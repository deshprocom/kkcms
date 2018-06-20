ActiveAdmin.register HotelOrder do
  menu parent: '酒店管理'
  actions :all, except: [:new, :edit, :create, :destroy]

  filter :user_email_or_user_mobile, as: :string
  filter :order_number

  index do
    render 'index', context: self
  end

  show do
    render 'show', context: self
  end
end
