class Pigeon < ApplicationRecord
  belongs_to :user
  has_many :rentals, dependent: :destroy
  has_many :reviews, through: :rentals

  validates :name, :address, :maximum_payload_weight, :range, :description, :price, presence: true

  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  WEIGHT = ["10g (ex: 1 USB key)",
            "20g (ex: 1 SIM CARD)",
            "30g (ex: 3 USB keys)",
            "40g (ex: 22 parchment papers)",
            "50g (ex: 1 SSD Hard drive)",
            "60g (ex: 1 SSD Hard drive & 1 USB key)"]

  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end

  def avg_rating
    avg = reviews.average(:rating)
    avg.nil? ? "-" : avg.round(2).to_s
  end
end
