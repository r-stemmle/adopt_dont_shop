require 'rails_helper'

RSpec.describe "Starting an Application" do
  describe "As a visitor when I visit the pet index page" do
    it "It has a link to 'Start an Application'" do
      visit '/pets'
      click_on "Start an Application"
      expect(current_path).to eq("/applications/new")
    end

    describe "the new application" do
      it "renders the new form" do
        visit '/applications/new'
        expect(page).to have_content('New Application')
        expect(find('form')).to have_content('Name')
        expect(find('form')).to have_content('Street')
        expect(find('form')).to have_content('City')
        expect(find('form')).to have_content('State')
        expect(find('form')).to have_content('Zip code')
      end
    end

    describe "application create" do
      context "given valid data" do
        it "creates the application" do
          visit '/applications/new'
          fill_in "Name", with: "Carol"
          fill_in "Street", with: "153 High Crest Road"
          fill_in "City", with: "Pelham"
          fill_in "State", with: "AL"
          fill_in "Zip code", with: "35124"
          click_on "Create Application"

          expect(page).to have_content("Carol")
          expect(page).to have_content("153 High Crest Road")
          expect(page).to have_content("Pelham")
          expect(page).to have_content("AL")
          expect(page).to have_content("35124")
          expect(page).to have_content("In Progress")
        end
      end

      context "given invalid data" do
        it "re-renders the new form" do
          visit '/applications/new'
          fill_in "Name", with: "Carol"
          fill_in "Street", with: "153 High Crest Road"
          fill_in "City", with: "Pelham"
          fill_in "State", with: "AL"
          click_on "Create Application"

          expect(page).to have_content("Error: Zip code can't be blank")
          expect(current_path).to eq('/applications/new')
        end
      end
    end
  end
end
