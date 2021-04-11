module OrdersHelper
  def valid_orders(orders)
    orders.filter{|order| order.total_price && order.total_price.positive? && order.status && order.delivery_mode && order.shipping_address}
  end
end
