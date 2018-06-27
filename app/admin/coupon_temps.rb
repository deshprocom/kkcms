ActiveAdmin.register CouponTemp do
  menu priority: 3, parent: '优惠券', label: '模版'
  permit_params :coupon_type, :name, :short_desc, :description, :published, :discount_type, :new_user, :limit_price, :reduce_price, :discount, :integral_on, :integrals
  actions :all, except: [:show]

  filter :new_user
  filter :integral_on

  index do
    render 'index', context: self
  end

  form partial: 'form'

  member_action :generate_coupons, method: [:get, :post] do
    return render :coupon unless request.post?
    params[:number].to_i.times.each do
      Coupon.create(coupon_temp: resource, expire_day: params[:expire_day])
    end
    redirect_back fallback_location: admin_coupon_temps_url, notice: '创建成功'
  end

  member_action :publish, method: :post do
    resource.publish!
    redirect_back fallback_location: admin_coupon_temps_url, notice: I18n.t('publish_notice')
  end

  member_action :unpublish, method: :post do
    resource.unpublish!
    redirect_back fallback_location: admin_coupon_temps_url, notice: I18n.t('unpublish_notice')
  end
end
