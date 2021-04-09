require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:applications_pets) }
    it { should have_many(:pets).through(:applications_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
  end

  before {
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @kon = @pet_1.applications.create!(name: "Kon", street: "123 nowhere", city: "sleepy", state: "TN", zip_code: 32322, justification: "I hate turtles", status: "Pending")
  }

  describe 'class methods' do
    describe 'pending' do
      it "returns applications that are pending" do
        expect(Application.pending).to eq([@kon])
      end
    end
  end
  describe 'instance methods' do
    describe 'application_pet' do
      it "returns pet associated with inquiry" do
        expect(@kon.application_pet(@pet_1.id)).to be_instance_of(ApplicationsPet)
      end
    end

    describe '.approved?' do
      it "returns true if all the pets on an application have been approved" do
        expect(@kon.approved?).to eq(false)
      end
    end

    describe '.rejected?' do
      it "returns true if any the pets on an application have been rejected" do
        expect(@kon.rejected?).to eq(false)
      end
    end
  end
end
