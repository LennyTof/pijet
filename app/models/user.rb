class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pigeons, dependent: :destroy
  has_many :rentals
  has_many :reviews
  has_one_attached :photo

  validates :first_name, presence: true
  validates :last_name, presence: true
end
