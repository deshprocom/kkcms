module HotelServices
  class AgreeRefund
    include Serviceable

    def initialize(refund)
      @refund = refund
      @order = refund.hotel_order
    end

    def call
      return error_result('状态不是待审核中，不允许操作') unless @refund.pending?
      
      return error_result('订单未付款，不允许退款') if @order.unpaid?

      return error_result('该订单已退款') if @order.refunded?

      return error_result('超出了可退款金额') if refundable_price_over?

      return error_result('已超过入住时间，不允许退款') if over_checkin_date?

      result = WxPay::Service.invoke_refund(refund_params)
      Rails.logger.info("Hotel::AgreeRefundService number=#{@refund.out_refund_no}: #{result}")
      unless sign_correct?(result[:raw]['xml'])
        return error_result('验证签名失败')
      end

      unless result.success?
        return error_result(result['err_code_des'])
      end

      @refund.completed!
      @order.update(status: 'refunded', refund_price: @refund.refund_price)
      ApiResult.success_result
    end

    def refundable_price_over?
      @refund.refund_price > @order.final_price
    end

    def over_checkin_date?
      Time.now > @order.checkin_date + 1.day
    end

    private

    def sign_correct?(result)
      WxPay::Sign.verify?(result)
    end

    def refund_params
      {
        out_refund_no: @refund.out_refund_no,
        out_trade_no: @order.order_number,
        refund_fee: (@refund.refund_price * 100).to_i,
        total_fee: (@order.final_price * 100).to_i
      }
    end
  end
end
