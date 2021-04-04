require 'rails_helper'

RSpec.describe 'application show page' do
  before :each do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @carol = Application.create!(
      name: "Carol Smith",
      street: "153 High Crest rd",
      city: "Pelham",
      state: "AL",
      zip_code: "35124",
     )
  end
  describe 'when I visit the applications show page' do
    context "for the first time" do
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

    context "the application has not been submitted" do
      describe "I see a section to add a pet to this application" do
        it "I input to search for pets by name" do
          visit "/applications/#{@carol.id}"

          fill_in "Pets by name", with: 'Lucille Bald'
          click_on "Search"
          expect(page).to have_content('Lucille Bald')
        end
      end
    end

  end
end
