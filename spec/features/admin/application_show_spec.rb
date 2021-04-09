require 'rails_helper'

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
          expect(page).to_not have_button("Approve")
          expect(page).to_not have_button("Reject")
          expect(page).to have_content("Approved")
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
          expect(page).to_not have_button("Approve")
          expect(page).to_not have_button("Reject")
          expect(page).to have_content("Rejected")
        end
      end
    end
  end

  describe "All pets accepted on an application" do
    it "I am taken back to the page and the applications status is approved" do
      visit "/admin/applications/#{@joe.id}"

      within "##{@rug.id}" do
        expect(page).to have_content("Rug")
        expect(page).to have_button("Approve")
        expect(page).to have_button("Reject")
        click_on "Approve"
      end
      within "##{@cat.id}" do
        expect(page).to have_content("Cat")
        expect(page).to have_button("Approve")
        expect(page).to have_button("Reject")
        click_on "Approve"
      end

      within ".applicant" do
        expect(page).to have_content("Approved")
      end
    end
    #     When I visit an admin application show page
    # And I approve all pets for an application
    # Then I am taken back to the admin application show page
    # And I see the application's status has changed to "Approved"
  end
end
