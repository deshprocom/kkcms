module AdminTrans
  EXCHANGE_TYPES = ExchangeRate.rate_types.keys.collect { |d| [I18n.t("exchange_rate.#{d}"), d] }

  SHIPPING_RULES = Shop::Shipping.calc_rules.keys.collect { |d| [I18n.t("shipping.#{d}"), d] }

  SOURCE_TYPES = %w[hotel info].collect { |d| [I18n.t("banner.#{d}"), d] }

  TRANS_TOPIC_STATUSES = Topic.statuses.keys.collect { |d| [I18n.t("status.#{d}"), d] }

  COUPON_TYPE = CouponTemp.coupon_types.keys.collect { |d| [I18n.t("coupon_type.#{d}"), d] }

  DISCOUNT_TYPE = CouponTemp.discount_types.keys.collect { |d| [I18n.t("discount_type.#{d}"), d] }
end