# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Application.destroy_all
Shelter.destroy_all
Pet.destroy_all


aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
arf = Shelter.create!(name: 'ARF', city: 'East Hampton, NY', foster_program: true, rank: 2)

Shelter.create(name: 'SPCA', city: 'Largo, CO', foster_program: true, rank: 1)
Shelter.create(name: 'baggies', city: 'Harlingen, TX', foster_program: false, rank: 5)
Shelter.create(name: 'FANCY pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

Application.create!(name: "Carol Smith", street: "153 High Crest rd", city: "Pelham", state: "AL", zip_code: "35124")

Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: aurora.id)
Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: aurora.id)

aurora.pets.create!(adoptable: false, age: 7, breed: 'schnoodle', name: 'Carl')
rug = arf.pets.create!(adoptable: true, age: 2, breed: 'mut', name: 'Rug')

app_pet1 = rug.applications.create!(name: "Edward Jones", street: "12277 94 street", city: "Largo", state: "FL", zip_code: "33773")
