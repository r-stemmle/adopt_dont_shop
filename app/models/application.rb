class Application < ApplicationRecord
  validates :name, :street, :city, :state, :zip_code, presence: true
  has_many :applications_pets
  has_many :pets, through: :applications_pets
  # has_and_belongs_to_many :pets


  def self.pending
    where(status: "Pending")
  end

  def application_pet(pet_id)
    applications_pets.find { |pet| pet.pet_id == pet_id }
  end

  def approved?
      applications_pets.all? {|a| a.status == "Approved" }
  end

  def rejected?
      applications_pets.any? {|a| a.status == "Rejected" }
  end
end
