class Item < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  has_and_belongs_to_many :promotions
  has_many :order_items, dependent: :destroy
  before_save :set_attributes

  scope :by_brand, -> (brand_name) { where(brand:Brand.where(name:brand_name))}
  scope :by_category, -> (category_name) { where(category:Category.where(name:category_name))}
  scope :by_promo, -> (boolean) { where(is_promo: boolean) }

  def biggest_discount
    current_all_promotions.map { |p| p.discount_fixed || (p.discount_percent && price * p.discount_percent / 100) || 0 }.max.to_i
  end

  def current_all_promotions
    # order by dateEnd then min requirement
    promotions.order(:date_end, :min).select { |p| Time.now >= p.date_start && Time.now <= p.date_end }
  end

  def under_promotion?
    current_all_promotions.any?
  end

  def price_after_biggest_discount
    price - biggest_discount
  end

  def latest_promotion
    current_all_promotions[0]
  end

  def discount?
    latest_promotion.discount_fixed.present? && latest_promotion.discount_fixed.positive?
  end

  def percent?
    latest_promotion.discount_percent.present? && latest_promotion.discount_percent.positive?
  end

  def gift?
    latest_promotion.gift.present?
  end

  def real_discount(fixed, percent)
    fixed || self.price * percent / 100
  end

  private

  def update_promo_status
    if under_promotion?
      self[:is_promo] = true
    else
      self[:is_promo] = false
    end
  end

  def set_attributes
    self[:is_promo] = under_promotion?
  end

end
