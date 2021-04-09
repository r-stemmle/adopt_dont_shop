require 'rails_helper'
# Approving a Pet for Adoption
#
# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved
RSpec.describe "admin application show page" do
  before {
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @rug = @shelter_1.pets.create!(adoptable: true, age: 2, breed: 'mut', name: 'Rug')
    @cat = @shelter_1.pets.create!(adoptable: true, age: 4, breed: 'poodle', name: 'Cat')
    @joe = @rug.applications.create!(name: "Joe", street: "123 nowhere", city: "sleepy", state: "TN", zip_code: 32322, justification: "I hate turtles", status: "Pending")
    @joe.pets << @cat
  }
  describe "for every pet that the application is for" do
    it "I see a button to approve or reject the application" do
      visit "/admin/applications/#{@joe.id}"

      within ".pet-answer" do
        expect(page).to have_button("Approve")
        expect(page).to have_button("Reject")
        save_and_open_page
      end
    end

    context "When I click approve" do
      it "I'm taken back to the admin application show page" do
        visit "/admin/applications/#{@joe.id}"

        within "##{@rug.id}" do
          expect(page).to have_content("Rug")
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")
          click_on "Approve"
          expect(current_path).to eq("/admin/applications/#{@joe.id}")
        end
      end
    end

    context "When I click reject" do
      it "I'm taken back to the admin application show page" do
        visit "/admin/applications/#{@joe.id}"

        within "##{@rug.id}" do
          expect(page).to have_content("Rug")
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")
          click_on "Reject"
          expect(current_path).to eq("/admin/applications/#{@joe.id}")
        end
      end
    end
  end
end
