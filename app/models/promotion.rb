class Promotion < ApplicationRecord
  require 'csv'

  has_and_belongs_to_many :items
  before_save :set_message
  before_save :set_items

  def promo_message
    return "Free #{gift} x #{gift_quantity} for above #{min} units" if has_gift?
    return "Discount RM#{discount_fixed} /item for above #{min} units" if has_percent_discount?
    return "Discount #{discount_percent}% /item for above #{min} units" if has_fixed_discount?

    "BUY #{min} FREE 1"
  end

  def set_items
    items_screened = Item.where('quantity > ?', 0)
    items_screened = items_screened.where(brand:Brand.where(name:item_brands)) if item_brands && item_brands.present?
    items_screened = items_screened.where(category:Category.where(name:item_categories)) if item_categories && item_categories.present?
    items_screened = items_screened.where(description:Item.pluck(:description).select{|d| d.include?(item_keyword)}) if item_keyword && item_keyword.present?
    self.items = items_screened
  end

  def self.feed_csv
    promotions = []
    CSV.foreach('./csv/sample_promo.csv', headers: true) do |row|
      hash = row.to_h
      cleaning(hash)
      set_discount(hash)
      hash['created_at'] = Time.now
      hash['updated_at'] = Time.now

      promotions << hash
    end
    Promotion.upsert_all(promotions)
    # To set message and items
    Promotion.find_each(&:save)
    # Update is_promo attribute
    Item.find_each(&:save)
  end

  private

  def self.cleaning(hash)
    hash.each do |k,v|
      hash[k].strip! if hash[k]
    end
    hash['item_categories'] = hash['item_categories'].split('|') if hash['item_categories']
    hash['item_brands'] = hash['item_brands'].split('|') if hash['item_brands']
  end

  def self.set_discount(hash)
  end

  def set_message
    self[:message] = promo_message if self[:message].nil? || self[:message].empty?
  end

  def has_percent_discount?
    !discount_percent.nil? && discount_percent.positive?
  end

  def has_fixed_discount?
    !discount_fixed.nil? && discount_fixed.positive?
  end

  def has_gift?
    !gift.nil? && !gift.empty?
  end
end
