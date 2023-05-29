class Pigeon < ApplicationRecord
  belongs_to :user
  has_many :rentals
  validates :name, :maximum_payload_weight, :range, :description, presence: true
end
