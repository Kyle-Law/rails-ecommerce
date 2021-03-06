class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[index]

  # GET /items or /items.json
  def index
    # To avoid initial alert from devise
    redirect_to new_user_session_path and return unless user_signed_in?


    @order_item = current_order.order_items.new
    @brands = Item.all.map{|i| i.brand.name}.uniq.sort
    @categories = Item.all.map{|i| i.category.name}.uniq.sort
    brand_selected = params[:itemBrand].present? ? params[:itemBrand] : @brands
    category_selected = params[:itemCategory].present? ? params[:itemCategory] : @categories
    promo_only = params[:promo_only].present?
    items_screened = Item.by_brand(brand_selected).by_category(category_selected)
    items_screened = items_screened.by_promo(true) if promo_only
    @items = items_screened
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :price, :quantity, :description, :photo_url, :brand_id, :category_id)
    end
end
