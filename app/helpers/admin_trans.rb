module AdminTrans
  EXCHANGE_TYPES = ExchangeRate.rate_types.keys.collect { |d| [I18n.t("exchange_rate.#{d}"), d] }

  SHIPPING_RULES = Shop::Shipping.calc_rules.keys.collect { |d| [I18n.t("shipping.#{d}"), d] }

  SOURCE_TYPES = %w[hotel info].collect { |d| [I18n.t("banner.#{d}"), d] }
end