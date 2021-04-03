require 'rails_helper'

RSpec.describe 'application show page' do
  before :each do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @carol = Application.create!(
      name: "Carol Smith",
      street: "153 High Crest rd",
      city: "Pelham",
      state: "AL",
      zip_code: "35124",
     )
  end
  describe 'when I visit the applications show page' do
    it "it displays name, address, justification, pets, status" do
      #dependencies: pets
      visit "/applications/#{@carol.id}"

      expect(page).to have_content(@carol.name)
      expect(page).to have_content(@carol.city)
      expect(page).to have_content(@carol.state)
      expect(page).to have_content(@carol.zip_code)
      expect(page).to have_content("In Progress")
    end
  end
end
