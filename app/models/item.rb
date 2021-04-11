class Item < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  has_and_belongs_to_many :promotions
  has_many :order_items, dependent: :destroy
  before_save :set_attributes

  private

  def update_promo_status
    if under_promotion?
      self[:is_promo] = true
    else
      self[:is_promo] = false
    end
  end

  def current_all_promotions
    # order by dateEnd then min requirement
    promotions.order(:date_end, :min).select { |p| Time.now >= p.date_start && Time.now <= p.date_end }
  end

  def under_promotion?
    current_all_promotions.any?
  end

  def set_attributes
    self[:is_promo] = under_promotion?
  end

end
