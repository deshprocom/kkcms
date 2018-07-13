ActiveAdmin.register Withdrawal do
  menu priority: 2, parent: '钱包管理'
  config.breadcrumb = false
  actions :all, except: [:new, :edit, :destroy]
  config.sort_order = 'created_at_desc'

  filter :user_nick_name, as: :string
  filter :user_mobile, as: :string
  filter :option_status, as: :select
  filter :account_type, as: :select
  filter :account_memo
  filter :created_at

  index do
    render 'index', context: self
  end
end
