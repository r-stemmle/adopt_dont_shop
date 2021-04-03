require 'rails_helper'

RSpec.describe "Starting an Application" do
  describe "As a visitor when I visit the pet index page" do
    it "It has a link to 'Start an Application'" do

      visit '/pets'

      click_on "Start an Application"

      expect(current_path).to eq("/applications/new")

      fill_in "Name", with: "Carol"
      fill_in "Street", with: "153 High Crest Road"
      fill_in "City", with: "Pelham"
      fill_in "State", with: "AL"
      fill_in "Zip code", with: "35124"
      click_on "Create Application"

      # expect(current_path).to eq("/applications/#{}")

      expect(page).to have_content("Carol")
      expect(page).to have_content("153 High Crest Road")
      expect(page).to have_content("Pelham")
      expect(page).to have_content("AL")
      expect(page).to have_content("35124")
      expect(page).to have_content("Why I would make a good home")
      expect(page).to have_content("In Progress")
    end
  end
end
