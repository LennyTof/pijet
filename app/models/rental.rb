class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :pigeon
  has_many :reviews, dependent: :destroy

  validates :user, presence: true
  validates :pigeon, presence: true
  validates :payload_weight, presence: true

  PAYLOAD_TYPES = [
    {
      name: "Paper",
      weight: 5
    },
    {
      name: "SD card",
      weight: 7
    },
    {
      name: "USB key",
      weight: 15
    },
    {
      name: "SSD Hard drive",
      weight: 50
    },
    {
      name: "Storage server",
      weight: 50_000
    }
  ]

  TAX_RATE = 0.2
  SERVICE_FEE_PER_DAY = 10
end
