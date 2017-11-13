require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.new(first_name: "John", last_name: "Doe", password: "john", password_confirmation: "john", email: "john@doe.mia")    
  end
  
  describe 'Validations' do
    it 'should create a user when password and password confirmation matches' do
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
      @user2 = User.new(first_name: "Jane", last_name: "Doe", password: "jane", password_confirmation: "jane", email: "john@doe.mia")      

      expect(@user1).to be_valid
      expect(@user1.save).to eq true

      expect(@user2).to_not be_valid
      expect(@user2.save).to eq false
    end
  
    it 'should not create a user when email already exist in the database with case insensitivty' do
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

    it 'should create a user when password is at least the minimum length' do
      @user = User.new(first_name: "John", last_name: "Doe", password: "john", password_confirmation: "john", email: "john@doe.mia")
      
      expect(@user).to be_valid
      expect(@user.save).to eq true
    end

    it 'should not create a user when password is below the minimum length' do
      @user = User.new(first_name: "John", last_name: "Doe", password: "joe", password_confirmation: "joe", email: "john@doe.mia")
      
      expect(@user).to_not be_valid
      expect(@user.save).to eq false
      expect(@user.errors.messages[:password].first).to match(/is too short/)
    end

    after(:all) do
      User.destroy_all
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    before(:all) do
      @user = User.create(first_name: "John", last_name: "Doe", password: "john", password_confirmation: "john", email: "john@doe.mia")      
    end

    it "should return a user when given correct credentials" do
      @user = User.authenticate_with_credentials("john@doe.mia", "john")
      expect(@user).to be_a(User)
    end

    it "should not return a user when given incorrect credentials" do
      @user = User.authenticate_with_credentials("john@doe.mia", "johnny")
      expect(@user).to be_nil
    end

    it "should return a user when given spaces before the email" do
      @user = User.authenticate_with_credentials("   john@doe.mia", "john")
      expect(@user).to be_a(User)
    end

    it "should return a user when given spaces after the email" do
      @user = User.authenticate_with_credentials("john@doe.mia    ", "john")
      expect(@user).to be_a(User)
    end

    after(:all) do
      User.destroy_all
    end
  end
end
