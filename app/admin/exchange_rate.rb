TRANS_EXCHANGE_TYPES = ExchangeRate.rate_types.keys.collect { |d| [I18n.t("exchange_rate.#{d}"), d] }

ActiveAdmin.register ExchangeRate do
  config.filters = false

  permit_params :s_currency, :t_currency, :rate, :rate_type
  form partial: 'form'

end
