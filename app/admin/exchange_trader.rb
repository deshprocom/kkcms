ActiveAdmin.register ExchangeTrader do
  menu parent: '外汇管理'
  config.filters = false
  config.sort_order = 'position_desc'

  permit_params :user_id, :position, :memo
  form partial: 'form'

  index do
    render 'index', context: self
  end
end
