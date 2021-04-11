class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @order.user_id = current_user.id
    # Save order first to have an order id
    @order.save
    # check for existed records to combine similar items
    existed_order = @order.order_items.find { |item| item.item_id == order_params[:item_id].to_i }
    if existed_order
      existed_order.quantity += order_params[:quantity].to_i
      existed_order.save
    else
      @order_item = @order.order_items.new(order_params)
      @order_item.save
    end

    # Save to update total price of the order
    @order.save
    session[:order_id] = @order.id
  end

  def update
    order_item = current_order.order_items.find(params[:id])
    order_item.update_attributes(order_params)
    @order_items = current_order.order_items
    @order_items.each(&:save)
    current_order.save
  end

  def destroy
    order_item = current_order.order_items.find(params[:id])
    order_item.destroy
    @order_items = current_order.order_items
    current_order.save
  end

  private

  def order_params
    params.require(:order_item).permit(:item_id, :quantity)
  end
end
