require 'rails_helper'

RSpec.describe 'the application' do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Englewood Shelter',
                                city: 'Englewood CO',
                                foster_program: false,
                                rank: 9)
    @pet_1 = Pet.create!(name: 'Alfie',
                        age: 1,
                        breed: 'Australian Shepard',
                        adoptable: true,
                        shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(name: 'Hazel',
                        age: 2,
                        breed: 'Nova Scotia Duck Tolling Retriever',
                        adoptable: true,
                        shelter_id: @shelter_1.id)
    @pet_3 = Pet.create!(name: 'Scout',
                        age: 6,
                        breed: 'Labrador Retriever',
                        adoptable: true,
                        shelter_id: @shelter_1.id)
    @application_1 = Application.create!(name: 'Natalie',
                                        street_address: '1234 Random St',
                                        city: 'Englewood',
                                        zip_code: '80205',
                                        description: 'Because I love dogs!')
    @application_1.pets << @pet_1
    @application_1.pets << @pet_2
  end

  describe 'display' do
    it 'shows the application and all its attributes' do
      visit "/applications/#{@application_1.id}"

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.street_address)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.zip_code)
      expect(page).to have_content(@application_1.description)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to_not have_content(@pet_3.name)
      expect(page).to have_content(@application_1.status)
    end
  end

  describe 'hyperlinks' do
    it 'pet names link to their pet show pages' do
      visit "/applications/#{@application_1.id}"
      click_on "#{@pet_1.name}"

      expect(current_path).to eq("/pets/#{@pet_1.id}")

      visit "/applications/#{@application_1.id}"
      click_on "#{@pet_2.name}"

      expect(current_path).to eq("/pets/#{@pet_2.id}")
    end
  end
end
