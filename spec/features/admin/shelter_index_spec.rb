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

  }
  describe "As a visitor to admin shelters index" do
    it "I see all shelters listed reverse alphabetical by name" do
      visit "/admin/shelters"


      expect(page).to have_content(@shelter_2.name.downcase)
      expect(page).to have_content(@shelter_3.name.downcase)
      expect(page).to have_content(@shelter_1.name.downcase)

    end
  end
end
