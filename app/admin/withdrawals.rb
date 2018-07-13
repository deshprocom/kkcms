ActiveAdmin.register Withdrawal do
  menu priority: 2, parent: '钱包管理'
  config.breadcrumb = false
  actions :all, except: [:new, :edit, :destroy]
  config.sort_order = 'created_at_desc'

  filter :user_nick_name, as: :string
  filter :user_mobile, as: :string
  filter :option_status, as: :select, collection: AdminTrans::WITHDRAWAL_OPTION_STATUS
  filter :account_type, as: :select, collection: AdminTrans::WITHDRAWAL_ACCOUNT_TYPE
  filter :account_memo
  filter :created_at

  index do
    render 'index', context: self
  end

  batch_action :'批量提现通过', confirm: '确定操作吗?' do |ids|
    Withdrawal.find(ids).each do |item|
      item.admin_change_status('success', current_admin_user&.email)
    end
    redirect_back fallback_location: admin_withdrawals_url, notice: '批量提现通过成功！'
  end

  batch_action :'批量提现失败', confirm: '确定操作吗?' do |ids|
    Withdrawal.find(ids).each do |item|
      item.admin_change_status('failed', current_admin_user&.email)
    end
    redirect_back fallback_location: admin_users_url, notice: '批量提现失败成功！'
  end
end
