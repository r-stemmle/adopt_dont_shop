class Application < ApplicationRecord
  validates :name, :street, :city, :state, :zip_code, presence: true
  # has_many :applications_pets
  # has_many :pets, through: :applications_pets
  has_and_belongs_to_many :pets 
end
