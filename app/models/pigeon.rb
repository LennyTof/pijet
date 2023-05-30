class Pigeon < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :rentals
  validates :name, :maximum_payload_weight, :range, :description, presence: true

  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end
end
