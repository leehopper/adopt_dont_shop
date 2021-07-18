shelter_1 = Shelter.create!(name: 'Englewood Shelter',
                city: 'Englewood CO',
                foster_program: false,
                rank: 9)
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
