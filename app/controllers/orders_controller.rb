class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  def shipping
    @order = current_order
    @order_items = current_order.order_items
    @order_items.each(&:save)
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    if current_order.total_price.positive?
      # To keep track of the order
      id = current_order.id

      # Once is_ordered == true, current_order is no longer the order.
      # That's why `order_date` update has to be prior to `is_ordered` update
      current_order.update(order_date: Time.now)
      current_order.update(status: 'Processing')

      @order = Order.find(id)
      session.delete(:order_id)

      @orders = Order.all
      render 'index' and return
    else
      redirect_to '/carts'
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def update
    if params[:id]
      order = Order.find(params[:id])
      order.update(order_params)
    else
      current_order.update(order_params)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:user_id, :total_price, :status, :credit, :remarks, :shipping_address, :notification_phone_number, :voucher_code, :delivery_mode_id)
    end
end
