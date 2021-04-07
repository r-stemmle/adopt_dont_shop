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
RSpec.describe "visit admin application show page" do
  before {
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @rug = @shelter_1.pets.create!(adoptable: true, age: 2, breed: 'mut', name: 'Rug')
    @joe = @rug.applications.create!(name: "Joe", street: "123 nowhere", city: "sleepy", state: "TN", zip_code: 32322, justification: "I hate turtles", status: "Pending")
  }
  it "I see a button to approve the application for that specific pet" do
    visit "/admin/applications/#{@joe.id}"

    expect(page).to have_button("Approve")
  end
end
