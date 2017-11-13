class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :reviews
end
