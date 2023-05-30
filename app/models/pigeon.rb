class Pigeon < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :rentals
  validates :name, :maximum_payload_weight, :range, :description, :price, presence: true
  WEIGHT = ["10g (ex: 1 USB key)",
            "20g (ex: 1 SIM CARD)",
            "30g (ex: 3 USB keys)",
            "40g (ex: 22 parchment papers)",
            "50g (ex: 1 SSD Hard drive)",
            "60g (ex: 1 SSD Hard drive & 1 USB key)"]
  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end
end
