class Application < ApplicationRecord
  validates :name, :street, :city, :state, :zip_code, presence: true
end
