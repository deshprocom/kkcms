module AdminTrans
  EXCHANGE_TYPES = ExchangeRate.rate_types.keys.collect { |d| [I18n.t("exchange_rate.#{d}"), d] }

  SOURCE_TYPES = %w[hotel info].collect { |d| [I18n.t("banner.#{d}"), d] }
end