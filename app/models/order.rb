class Order < ActiveRecord::Base
  after_create :deduct_products_quantity

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  protected
    def deduct_products_quantity
      self.line_items.each do |line_item|
        product = Product.find(line_item.product_id)

        product.quantity -= line_item.quantity
        product.save!
      end
    end
end
