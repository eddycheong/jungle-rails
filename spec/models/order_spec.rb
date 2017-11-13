require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      @category = Category.create!;
      # Setup at least two products with different quantities, names, etc
      @product1 = @category.products.create!(name: "Soap", price: 1.00, quantity: 20)
      @product2 = @category.products.create!(name: "Shampoo", price: 3.00, quantity: 10)
      # Setup at least one product that will NOT be in the order
      @product3 = @category.products.create!(name: "Towel", price: 5.00, quantity: 7)
    end
    it 'deducts quantity from products based on their line item quantities' do
      # setup
      original_quantity1 = @product1.quantity
      original_quantity2 = @product2.quantity

      quantity1 = 5
      quantity2 = 6

      cart_total = (@product1.price * quantity1 + @product2.price * quantity2) * 100

      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(
        total_cents: cart_total,
        stripe_charge_id: "test"
      )
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: quantity1,
        item_price: @product1.price,
        total_price: @product1.price * quantity1
      )

      @order.line_items.new(
        product: @product2,
        quantity: quantity2,
        item_price: @product2.price,
        total_price: @product2.price * quantity2
      )

      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eq(original_quantity1-quantity1)
      expect(@product2.quantity).to eq(original_quantity2-quantity2)
    end

    
    it 'does not deduct quantity from products that are not in the order' do
      # setup
      original_quantity1 = @product1.quantity
      original_quantity2 = @product2.quantity
      original_quantity3 = @product3.quantity

      quantity1 = 5
      quantity2 = 6

      cart_total = (@product1.price * quantity1 + @product2.price * quantity2) * 100

      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(
        total_cents: cart_total,
        stripe_charge_id: "test"
      )
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: quantity1,
        item_price: @product1.price,
        total_price: @product1.price * quantity1
      )

      @order.line_items.new(
        product: @product2,
        quantity: quantity2,
        item_price: @product2.price,
        total_price: @product2.price * quantity2
      )

      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      @product3.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eq(original_quantity1-quantity1)
      expect(@product2.quantity).to eq(original_quantity2-quantity2)
      expect(@product3.quantity).to eq(original_quantity3)
    end
  end
end
