class RefundService
  include Serviceable

  def initialize(order, refund)
    @order = order
    @refund = refund
  end

  def call
    result = WxPay::Service.invoke_refund(refund_params)
    Rails.logger.info("RefundService wx number=#{@refund.out_refund_no}: #{result}")
    unless sign_correct?(result[:raw]['xml'])
      return error_result('验证签名失败')
    end

    unless result.success?
      return error_result(result['err_code_des'])
    end

    ApiResult.success_result
  end

  def sign_correct?(result)
    WxPay::Sign.verify?(result)
  end

  def refund_params
    {
      out_refund_no: @refund.out_refund_no,
      refund_fee:    (@refund.refund_price * 100).to_i,
      out_trade_no:  @order.order_number,
      total_fee:     (@order.final_price * 100).to_i
    }
  end
end


