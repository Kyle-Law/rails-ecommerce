class CartsController < ApplicationController
  def show
    current_order.save
    @order_items = current_order.order_items
    authorize @order_items
  end

  def empty
    current_order.order_items.destroy_all
    current_order.save
    @order_items = current_order.order_items
    render 'show'
  end
end
