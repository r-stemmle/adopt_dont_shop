class Application < ApplicationRecord
  validates :name, :street, :city, :state, :zip_code, presence: true
  has_many :applications_pets
  has_many :pets, through: :applications_pets
end
