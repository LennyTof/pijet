class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :pigeon
  belongs_to :payload_type
  has_many :reviews

  validates :user, presence: true
  validates :pigeon, presence: true
  validates :payload_type, presence: true
end
