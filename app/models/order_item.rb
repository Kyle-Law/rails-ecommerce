class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  before_save :set_unit_price
  before_save :set_sub_total
  before_save :set_unit_discount

  before_save :set_attributes

  default_scope { order(created_at: :desc) }

  def promos_reached
    item.current_all_promotions.select{|p| p.mixable ? order.promotion_book[p]['mix'] >= p.min : order.promotion_book[p][self] >= p.min}
  end

  def cal_unit_discount
    if item.under_promotion? && promo_applying && promo_applying.discount_fixed.to_i.positive?
      return promo_applying.discount_fixed
    end
    if item.under_promotion? && promo_applying && promo_applying.discount_percent
      return item.price * promo_applying.discount_percent / 100
    end
    0
  end

  def promo_applying
    promos_reached.max { |p1, p2| p1.discount_fixed||0 - p2.discount_fixed || 0 }
  end

  def promos_yet_reached
    if promos_reached[0]

      return item.current_all_promotions.select { |p| p_discount = item.real_discount(p.discount_fixed,p.discount_percent);applying_discount = item.real_discount(promo_applying.discount_fixed,promo_applying.discount_percent); p.mixable ? order.promotion_book[p]['mix'] < p.min && p_discount > applying_discount : order.promotion_book[p][self]< p.min && p_discount > applying_discount}
    end

    item.current_all_promotions

  end

  def promo_prompting
    promos_yet_reached.min_by { |p| p.mixable ? p.min - order.promotion_book[p]['mix'] : p.min - order.promotion_book[p][self] }
  end

  private

  def set_attributes
    self[:unit_price] = item.price
    self[:sub_total] = (unit_price.to_f - unit_discount.to_f) * quantity.to_i
  end

  def set_unit_price
    self[:unit_price] = item.price
  end

  def set_sub_total
    self[:sub_total] = (unit_price.to_f - unit_discount.to_f) * quantity.to_i
  end

   def set_unit_discount
    self[:unit_discount] = cal_unit_discount.to_i
  end
end
