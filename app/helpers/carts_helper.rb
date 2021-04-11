module CartsHelper
  def x_item_more(item,promotion_book)
    next_promo = item.promo_prompting
    if next_promo && next_promo.mixable
      return next_promo.min - promotion_book[next_promo]['mix']
    end
    next_promo.min - promotion_book[next_promo][item]
  end


end
