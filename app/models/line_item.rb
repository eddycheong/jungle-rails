class LineItem < ActiveRecord::Base

  before_validation :fix_up_cached_prices

  belongs_to :order
  belongs_to :product

  monetize :item_price_cents, numericality: true
  monetize :total_price_cents, numericality: true

  protected
  def fix_up_cached_prices
    # weird question: what if they did set a total_price, but did not set a per-item ???

    if (!item_price_cents)
      self.item_price_cents = product.price
    end
    if (!total_price_cents)
      self.total_price_cents = item_price_cents * quantity
    end
  end

end
