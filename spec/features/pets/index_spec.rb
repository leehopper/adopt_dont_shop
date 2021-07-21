require 'rails_helper'

RSpec.describe 'the pets index' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: @shelter.id)
  end
  describe 'display' do
    it 'lists all the pets with their attributes' do
      visit "/pets"

      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.breed)
      expect(page).to have_content(@pet_1.age)
      expect(page).to have_content(@shelter.name)

      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_2.breed)
      expect(page).to have_content(@pet_2.age)
      expect(page).to have_content(@shelter.name)
    end

    it 'only lists adoptable pets' do
      visit "/pets"

      expect(page).to_not have_content(@pet_3.name)
    end
  end

  describe 'hyperlinks and buttons' do
    it 'displays a button to edit each pet' do
      visit '/pets'

      expect(page).to have_selector(:link_or_button, "Edit #{@pet_1.name}")
      expect(page).to have_selector(:link_or_button, "Edit #{@pet_2.name}")

      click_button("Edit #{@pet_1.name}")

      expect(page).to have_current_path("/pets/#{@pet_1.id}/edit")
    end

    it 'displays a button to delete each pet' do
      visit '/pets'

      expect(page).to have_selector(:link_or_button, "Delete #{@pet_1.name}")
      expect(page).to have_selector(:link_or_button, "Delete #{@pet_2.name}")

      click_button("Delete #{@pet_1.name}")

      expect(page).to have_current_path("/pets")
      expect(page).to_not have_content(@pet_1.name)
    end

    it 'displays a link to start an application' do
      visit '/pets'

      click_link('Start an Application')

      expect(current_path).to eq('/applications/new')
    end
  end

  describe 'content filtering' do
    it 'has a text box to filter results by keyword' do
      visit "/pets"
      expect(page).to have_button("Search")
    end

    it 'lists partial matches as search results' do
      pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
      pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: @shelter.id)
      pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: @shelter.id)

      visit "/pets"

      fill_in 'Search', with: "Ba"
      click_on("Search")

      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)
      expect(page).to_not have_content(pet_3.name)
    end
  end
end
