require 'rails_helper'

RSpec.describe 'the admin shelter show page' do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Englewood Shelter', city: 'Englewood CO', foster_program: false, rank: 9)
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
end
