require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create a user when password and password confirmation matches' do
      @user = User.new(first_name: "John", last_name: "Doe", password: "john", password_confirmation: "john", email: "john@doe.mia")

      expect(@user).to be_valid
      expect(@user.save).to eq true
    end

    it 'should not create a user when password and password confirmation mismatches' do
      @user = User.new(first_name: "John", last_name: "Doe", password: "john", password_confirmation: "doe", email: "john@doe.mia")

      expect(@user).to_not be_valid
      expect(@user.save).to eq false
    end

    it 'should not create a user when email already exist in the database' do
      @user1 = User.new(first_name: "John", last_name: "Doe", password: "john", password_confirmation: "john", email: "john@doe.mia")
      @user2 = User.new(first_name: "Jane", last_name: "Doe", password: "jane", password_confirmation: "jane", email: "JOHN@doe.mia")      

      expect(@user1).to be_valid
      expect(@user1.save).to eq true

      expect(@user2).to_not be_valid
      expect(@user2.save).to eq false
    end
    
    it 'should not create a user when first_name is missing' do
      @user = User.new(last_name: "Doe", password: "john", password_confirmation: "john", email: "john@doe.mia")
      
      expect(@user).to_not be_valid
      expect(@user.save).to eq false
      expect(@user.errors.messages[:first_name]).to eq ['can\'t be blank']
    end

    it 'should not create a user when last_name is missing' do
      @user = User.new(first_name: "John", password: "john", password_confirmation: "john", email: "john@doe.mia")
      
      expect(@user).to_not be_valid
      expect(@user.save).to eq false
      expect(@user.errors.messages[:last_name]).to eq ['can\'t be blank']
    end


    it 'should not create a user when email is missing' do
      @user = User.new(first_name: "John", last_name: "Doe", password: "john", password_confirmation: "john")
      
      expect(@user).to_not be_valid
      expect(@user.save).to eq false
      expect(@user.errors.messages[:email]).to eq ['can\'t be blank']
    end
  end
end
