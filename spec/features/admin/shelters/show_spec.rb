require 'rails_helper'

RSpec.describe 'the admin shelter show page' do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Englewood Shelter', city: 'Englewood CO', foster_program: true, rank: 9)
    @pet_1 = Pet.create!(name: 'Alfie', age: 1, breed: 'Australian Shepard', adoptable: true, shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(name: 'Hazel', age: 2, breed: 'Nova Scotia Duck Tolling Retriever', adoptable: true, shelter_id: @shelter_1.id)
    @pet_3 = Pet.create!(name: 'Scout', age: 6, breed: 'Labrador Retriever', adoptable: true, shelter_id: @shelter_1.id)
    @application = Application.create!(name: 'Natalie', street_address: '1234 Random St', city: 'Englewood', state: 'CO', zip_code: '80205', description: 'Because I am the best', status: 'pending')
  end

  it 'displays shelter name and address' do
    visit "/admin/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.city)
  end

  describe 'shelter statistics' do
    it 'displays no pets if no adoptable pets' do
      shelter_2 = Shelter.create!(name: 'Test', city: 'Englewood CO', foster_program: true, rank: 9)

      visit "/admin/shelters/#{shelter_2.id}"

      expect(page).to have_content('NO PETS')
    end

    it 'displays average age of adoptable pets' do
      visit "/admin/shelters/#{@shelter_1.id}"

      expect(page).to have_content('Statistics')
      expect(page).to have_content('Average Age of Adoptable Pets: 3')
    end

    it 'displays number of adoptable pets' do
      @pet_3.update(adoptable: false)
      visit "/admin/shelters/#{@shelter_1.id}"

      expect(page).to have_content('Total Adoptable Pets: 2')
    end

    it 'displays total pets adopted' do
      @application.pets << @pet_1
      @application.pets << @pet_2
      @application.submit('Test')

      pet_app_1 = PetApplication.locate_record(@application.id, @pet_1.id)
      pet_app_2 = PetApplication.locate_record(@application.id, @pet_2.id)

      pet_app_1.approve
      pet_app_2.approve
      @application.approve?

      visit "/admin/shelters/#{@shelter_1.id}"

      expect(page).to have_content('Total Adopted Pets (from this shelter): 2')
      expect(page).to have_content('Total Adoptable Pets: 1')
    end
  end

  describe 'action required' do
    it 'displays list of pets for this shelter with a pending application' do
      visit "/admin/shelters/#{@shelter_1.id}"

      within ("#action_required") do
        expect(page).to have_content('No pets with pending applicaitons')
      end

      @application.pets << @pet_1
      @application.pets << @pet_2
      @application.submit('Test')

      visit "/admin/shelters/#{@shelter_1.id}"

      within ("#action_required") do
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_2.name)
        expect(page).to_not have_content(@pet_3.name)
      end
    end
  end
end
