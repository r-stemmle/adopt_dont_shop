class ApplicationsPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  validates_uniqueness_of :pet_id, :scope => :application_id
end
