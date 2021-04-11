class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true

  belongs_to :shelter

  has_many :applications_pets
  has_many :applications, through: :applications_pets
  # has_and_belongs_to_many :applications


  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def count_pending_applications
    applications.pending.count
  end

  def application_status(applicant)
    applications_pets.joins(:application)
                     .where("application_id = #{applicant.id}")
                      .pluck(:status)
                      .first

  end
end
