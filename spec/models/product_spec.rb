require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'should create a Product' do
      @category = Category.new
      @product = @category.products.new(name: "Nintendo Switch", price: 499.99, quantity: 2)
      
      @product.save
      expect(@product).to be_valid
    end
    it 'should not create Product if missing category' do
      @product = Product.new(name: "Nintendo Switch", price: 499.99, quantity: 2)
      
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:category]).to eq ['can\'t be blank']
    end
    it 'should not create Product if missing name' do
      @category = Category.new
      @product = @category.products.new(price: 499.99, quantity: 2)
      
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:name]).to eq ['can\'t be blank']
    end
    it 'should not create Product if missing price' do
      @category = Category.new
      @product = Product.new(name: "Nintendo Switch", quantity: 2)
      
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:price]).to eq ['is not a number', 'can\'t be blank']
    end
    it 'should not create Product if missing quantity' do
      @category = Category.new
      @product = Product.new(name: "Nintendo Switch", price: 499.99)
      
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to eq ['can\'t be blank']
    end
  end
end
