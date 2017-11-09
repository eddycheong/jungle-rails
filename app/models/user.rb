class User < ActiveRecord::Base
  validates :email, uniqueness: true
  validates :password_digest, confirmation: true
  validates :password_digest_confirmation, presence: true
end
