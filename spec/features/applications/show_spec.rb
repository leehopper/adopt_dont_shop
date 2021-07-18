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
                                        state: 'CO',
                                        zip_code: '80205',
                                        description: 'Because I love dogs!')
  end
  describe 'display' do
    context 'attributes' do
      it 'shows the application and all its attributes' do
        @application_1.pets << @pet_1
        @application_1.pets << @pet_2

        visit "/applications/#{@application_1.id}"

        within('#attributes') do
          expect(page).to have_content(@application_1.name)
          expect(page).to have_content(@application_1.street_address)
          expect(page).to have_content(@application_1.city)
          expect(page).to have_content(@application_1.zip_code)
          expect(page).to have_content(@application_1.description)
        end
      end
    end
    context 'selected_pets and status' do
      it 'shows pets selected and status of application' do
        @application_1.pets << @pet_1
        @application_1.pets << @pet_2

        visit "/applications/#{@application_1.id}"

        within('#selected_pets') do
          expect(page).to have_content(@pet_1.name)
          expect(page).to have_content(@pet_2.name)
          expect(page).to_not have_content(@pet_3.name)
        end
      end
    end
    context 'status' do
      it 'shows status of application' do
        @application_1.pets << @pet_1
        @application_1.pets << @pet_2

        visit "/applications/#{@application_1.id}"

        within('#status') do
          expect(page).to have_content(@application_1.status)
        end
      end
    end
  end
  describe 'functionality' do
    context 'selected_pets' do
      it 'selected pet names link to their pet show pages' do
        @application_1.pets << @pet_1
        @application_1.pets << @pet_2

        visit "/applications/#{@application_1.id}"

        within('#selected_pets') do
          click_on "#{@pet_1.name}"
          expect(current_path).to eq("/pets/#{@pet_1.id}")
        end

        visit "/applications/#{@application_1.id}"

        within('#selected_pets') do
          click_on "#{@pet_2.name}"
          expect(current_path).to eq("/pets/#{@pet_2.id}")
        end
      end
    end
    context 'searched_pets' do
      context 'exact match' do
        it 'returns pet name' do
          visit "/applications/#{@application_1.id}"

          fill_in 'Search', with: 'Alfie'
          click_button 'Search'

          expect(current_path).to eq("/applications/#{@application_1.id}")

          within('#searched_pets') do
            expect(page).to have_content(@pet_1.name)
            expect(page).to_not have_content(@pet_2.name)
          end
        end
      end
      context 'no match' do
        it 'returns no matching pets' do
          visit "/applications/#{@application_1.id}"

          expect(page).to_not have_content("No matching pets")

          fill_in 'Search', with: 'Bill'
          click_button 'Search'

          within('#searched_pets') do
            expect(current_path).to eq("/applications/#{@application_1.id}")
            expect(page).to have_content("No matching pets")
          end
        end
      end
      context 'search results buttons' do
        it 'adopt this pet button adds pet to selected pets' do
          visit "/applications/#{@application_1.id}"

          fill_in 'Search', with: 'Alfie'
          click_button 'Search'

          within('#selected_pets') do
            expect(page).to_not have_content(@pet_1.name)
          end

          click_button 'Adopt this Pet'

          within('#selected_pets') do
            expect(page).to have_content(@pet_1.name)
            expect(page).to_not have_content(@pet_2.name)
            expect(page).to_not have_content(@pet_3.name)
          end
        end
      end
    end
  end
end
