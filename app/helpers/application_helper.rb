module ApplicationHelper
  def current_order
    previous_order = current_user.orders.find_by(status: nil)
    return previous_order if previous_order

    order = Order.new
    # save to get order_id
    order.user = current_user
    order.save
    order
  end

  def mobile_device
    agent = request.user_agent
    return 'tablet' if agent =~ /(tablet|ipad)|(android(?!.*mobile))/i
    return 'mobile' if agent =~ /Mobile/

    'desktop'
  end
end
