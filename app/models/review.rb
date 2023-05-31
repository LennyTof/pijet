class Review < ApplicationRecord
  belongs_to :user
  belongs_to :rental

  validates :comment, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: 0..5 }
end
