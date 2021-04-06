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

    context "I see the pet that I have searched for" do
      describe "Next to each pets name I see 'Adopt this pet' button" do
        it "I can click the button" do

          visit "/applications/#{@carol.id}"

          fill_in "Pets by name", with: 'Lucille Bald'
          click_on "Search"
          expect(page).to have_content('Lucille Bald')
          click_on "Adopt this Pet"

        end
      end
    end

    context "And I search for Pets by name" do
      it "I see any pet whose name PARTIALLY matches my search" do
        fluffy = Pet.create!(name: "fluffy", age: 4, breed: "poodle", shelter_id: @shelter.id, adoptable: true )
        fluff = Pet.create!(name: "fluff", age: 2, breed: "poodle", shelter_id: @shelter.id, adoptable: true )
        mr_fluff = Pet.create!(name: "mr. fluff", age: 5, breed: "poodle", shelter_id: @shelter.id, adoptable: true )

        visit "/applications/#{@carol.id}"
        fill_in "Pets by name", with: 'fluff'
        click_on "Search"
        expect(page).to have_content('fluffy')
        expect(page).to have_content('fluff')
        expect(page).to have_content('mr. fluff')
      end
    end

    context "I have clicked adopt this pet" do
      describe "I am taken back to applications show page" do
        it "displays the pet I want to adopt" do

        visit "/applications/#{@carol.id}"
        fill_in "Pets by name", with: 'Lucille Bald'
        click_on "Search"
        expect(page).to have_content('Lucille Bald')
        click_on "Adopt this Pet"
        expect(page).to have_content('Lucille Bald')
        end
      end
    end

    context "I have added pet(s) to the application" do
      it "submit an application" do

        visit "applications/#{@carol.id}"

        fill_in "Pets by name", with: 'Lucille Bald'
        click_on "Search"
        expect(page).to have_content('Lucille Bald')
        click_on "Adopt this Pet"
        expect(page).to have_content('Submit my application')
        fill_in "Why I'd make a good home", with: "I hate turtles"
        click_on "Submit"
        expect(current_path).to eq("/applications/#{@carol.id}")
        expect(page).to have_content("Pending")
        expect(page).to have_content('Lucille Bald')
        expect(page).to have_no_content('Add a Pet to this Application')
      end
    end
  end
end
