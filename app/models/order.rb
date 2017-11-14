class Order < ActiveRecord::Base
  before_validation :calculate_total_cents
  after_create :deduct_products_quantity

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  protected
    def calculate_total_cents
      self.total = 0

      if (self.line_items)
        self.line_items.each do |line_item|
          line_item.valid?
          self.total += line_item.item_price * line_item.quantity
        end
      end
    end

    def deduct_products_quantity
      self.line_items.each do |line_item|
        product = line_item.product

        product.quantity -= line_item.quantity
        product.save!
      end
    end
end
