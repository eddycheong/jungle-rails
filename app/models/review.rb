class Review < ActiveRecord::Base
  validates :product_id, :user_id, presence: true
  validates :rating, inclusion: { in: (1..5) }

  belongs_to :product
  belongs_to :user
end
