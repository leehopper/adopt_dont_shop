shelter_1 = Shelter.create!(name: 'Englewood Shelter',
                            city: 'Englewood CO',
                            foster_program: false,
                            rank: 9)
shelter_2 = Shelter.create!(name: 'Denver Shelter',
                            city: 'Denver CO',
                            foster_program: true,
                            rank: 5)
shelter_3 = Shelter.create!(name: 'Littleton Shelter',
                            city: 'Littleton CO',
                            foster_program: false,
                            rank: 8)
pet_1 = Pet.create!(name: 'Alfie',
                    age: 1,
                    breed: 'Australian Shepard',
                    adoptable: true,
                    shelter_id: shelter_1.id)
pet_2 = Pet.create!(name: 'Hazel',
                    age: 2,
                    breed: 'Nova Scotia Duck Tolling Retriever',
                    adoptable: true,
                    shelter_id: shelter_1.id)
pet_3 = Pet.create!(name: 'Scout',
                    age: 6,
                    breed: 'Labrador Retriever',
                    adoptable: true,
                    shelter_id: shelter_1.id)
pet_4 = Pet.create!(name: 'Alfred',
                    age: 6,
                    breed: 'Labrador Retriever',
                    adoptable: true,
                    shelter_id: shelter_1.id)
pet_5 = Pet.create!(name: 'Bilbo',
                    age: 4,
                    breed: 'Mixed Breed',
                    adoptable: true,
                    shelter_id: shelter_3.id)
pet_6 = Pet.create!(name: 'Frodo',
                    age: 7,
                    breed: 'Golden Retriever',
                    adoptable: true,
                    shelter_id: shelter_3.id)
pet_7 = Pet.create!(name: 'Sam',
                    age: 3,
                    breed: 'Husky',
                    adoptable: true,
                    shelter_id: shelter_3.id)
pet_8 = Pet.create!(name: 'Merry',
                    age: 10,
                    breed: 'Poodle',
                    adoptable: true,
                    shelter_id: shelter_3.id)
pet_9 = Pet.create!(name: 'Harry',
                    age: 4,
                    breed: 'Mixed Breed',
                    adoptable: true,
                    shelter_id: shelter_2.id)
pet_10 = Pet.create!(name: 'Ron',
                    age: 7,
                    breed: 'Golden Retriever',
                    adoptable: true,
                    shelter_id: shelter_2.id)
pet_11 = Pet.create!(name: 'Hermione',
                    age: 3,
                    breed: 'Husky',
                    adoptable: true,
                    shelter_id: shelter_2.id)
pet_12 = Pet.create!(name: 'Neville',
                    age: 10,
                    breed: 'Poodle',
                    adoptable: true,
                    shelter_id: shelter_2.id)
