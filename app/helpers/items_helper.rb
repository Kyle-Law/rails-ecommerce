module ItemsHelper
  def max_quantity(quantity)
    if quantity > 50
      50
    else
      quantity
    end
  end

end
