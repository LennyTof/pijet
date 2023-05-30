class Pigeon < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :rentals
  validates :name, :maximum_payload_weight, :range, :description, :price, presence: true
end
