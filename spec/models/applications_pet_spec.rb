require 'rails_helper'

RSpec.describe ApplicationsPet, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  describe 'validations' do
    it "No duplicate records" do
      @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
      @carol = @pet_1.applications.create!(
        name: "Carol Smith",
        street: "153 High Crest rd",
        city: "Pelham",
        state: "AL",
        zip_code: "35124",
       )
      should validate_uniqueness_of(:pet_id).scoped_to(:application_id)
    end
  end
end
