class User < ActiveRecord::Base
  validates :email, uniqueness: true
  validates :password, confirmation: true
  has_secure_password

end
