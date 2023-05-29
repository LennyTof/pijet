class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :pigeon
  belongs_to :payload_type
  has_many :reviews
end
