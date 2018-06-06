module Shop
  ActiveAdmin.register CustomerReturn, as: 'CustomerReturn', namespace: :shop do
    config.batch_actions = false
    config.filters = false

    menu priority: 3, parent: '订单管理', label: '退换货列表'

    actions :all, except: [:new, :edit, :create, :destroy]
    index do
      render 'index', context: self
    end

    show do
      render 'show'
    end

    member_action :agree, method: [:get, :post] do
      return if request.get?

      if params[:confirm_code] != 'confirm'
        flash[:error] = '输入确认码有误'
      else
        flash[:notice] = '退换成功'
      end

      # result = Services::ShopOrders::RefundService.call(@refund)
      # if result.failure?
      #   flash[:error] = result.msg
      #   return redirect_back fallback_location: shop_product_refunds_url
      # end
      redirect_to resource_url(resource)
    end

    member_action :refuse, method: [:get, :post] do
      return if request.get?

      if params[:admin_memo].blank?
        flash[:error] = '拒绝原因不能为空'
      else
        resource.update(return_status: 'refused', admin_memo: params[:admin_memo])
        resource.return_items.each(&:refused!)
        flash[:notice] = '已拒绝退换货'
      end

      redirect_to resource_url(resource)
    end
  end
end

