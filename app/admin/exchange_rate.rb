ActiveAdmin.register ExchangeRate do
  menu parent: '外汇管理'
  config.filters = false

  permit_params :s_currency, :s_currency_no, :t_currency, :t_currency_no, :rate, :rate_type
  form partial: 'form'

  index do
    id_column
    column :s_currency
    column :s_currency_no
    column :t_currency
    column :t_currency_no
    column(:rate_type) { |rate| I18n.t("exchange_rate.#{rate.rate_type}") }
    column :rate
    column :updated_at
    actions
  end
end
