require 'rails_helper'


# For this story, you should write your queries in raw sql. You can use the
# ActiveRecord find_by_sql method to execute raw sql queries:
# https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql
#
# Admin Shelters Index
#
# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see all Shelters in the system listed in reverse alphabetical order by name
RSpec.describe "Admin Shelters Index" do
  before {
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @rug = @shelter_1.pets.create!(adoptable: true, age: 2, breed: 'mut', name: 'Rug')
    @joe = @rug.applications.create!(name: "Joe", street: "123 nowhere", city: "sleepy", state: "TN", zip_code: 32322, justification: "I hate turtles", status: "Pending")
  }
  describe "As a visitor to admin shelters index" do

    it "I see all shelters listed reverse alphabetical by name" do
      visit "/admin/shelters"

      within '.shelter-all' do
        expect(@shelter_2.name.downcase).to appear_before(@shelter_3.name.downcase)
        expect(@shelter_3.name.downcase).to appear_before(@shelter_1.name.downcase)
      end
    end

    it "I see a section for shelters with pending applications" do
      visit "/admin/shelters"

      expect(page).to have_content("Pending Applications")
      expect(page).to have_content(@shelter_1.name)
    end
  end
end
