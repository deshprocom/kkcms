module Shop
  class AgreeCustomerReturnService
    include Serviceable

    def initialize(customer_return)
      @c_return = customer_return
      @order = customer_return.order
    end

    def call
      return error_result('状态不是待审核中，不允许操作') unless @c_return.pending?

      send("process_#{@c_return.return_type}")
    end

    # 如果是换货类型直接确认成功
    def precess_exchange_goods
      complete_return!
      ApiResult.success_result
    end

    def process_refund
      return error_result('超出了可退款金额') if refundable_price_over?

      # result = WxPay::Service.invoke_refund(refund_params)
      # Rails.logger.info("ShopOrders::RefundService number=#{@c_return.refund_number}: #{result}")
      # unless sign_correct?(result[:raw]['xml'])
      #   return error_result('验证签名失败')
      # end
      #
      # unless result.success?
      #   return error_result(result['err_code_des'])
      # end
      #

      complete_return!
      calc_order_refunded_price!
      ApiResult.success_result
    end

    def refundable_price_over?
      @c_return.refund_price > @order.refundable_price
    end

    def complete_return!
      @c_return.completed!
      @c_return.return_items.each(&:completed!)
    end

    # 计算该订单已退款的的金额并标记相应的order_item 的已退款状态为true
    def calc_order_refunded_price!
      @order.update(refunded_price:@order.refunded_price + @c_return.refund_price)
      @c_return.return_items.each { |item| item.order_item.update(refunded: true) }
    end

    private

    def sign_correct?(result)
      WxPay::Sign.verify?(result)
    end

    def refund_params
      {
        out_refund_no: @c_return.refund_number,
        out_trade_no: @c_return.product_order.order_number,
        refund_fee: (@c_return.refund_price * 100).to_i,
        total_fee: (@c_return.product_order.final_price * 100).to_i
      }
    end
  end
end
