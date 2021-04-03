require 'rails_helper'

RSpec.describe 'application show page' do
  before :each do
    @carol = Application.create!(
      name: "Carol Smith",
      street: "153 High Crest rd",
      city: "Pelham",
      state: "AL",
      zip_code: "35124",
      justification: "Big yard and I work from home")
  end
  describe 'when I visit the applications show page' do
    it "it displays name, address, description, pets, status" do
      #dependencies: pets
      visit "/applications/#{@carol.id}"

      expect(page).to have_content(@carol.name)
      expect(page).to have_content(@carol.city)
      expect(page).to have_content(@carol.state)
      expect(page).to have_content(@carol.zip_code)
      expect(page).to have_content(@carol.justification)
      expect(page).to have_content("In Progress")
    end
  end
end
