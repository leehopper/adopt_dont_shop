require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
  end

  it 'lists all the shelter names' do
    visit '/admin/shelters'

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  it 'lists all shelters in reverse alphabetical order' do
    visit '/admin/shelters'

    first = find("#shelter-#{@shelter_2.id}")
    mid = find("#shelter-#{@shelter_3.id}")
    last = find("#shelter-#{@shelter_1.id}")

    expect(first).to appear_before(mid)
    expect(mid).to appear_before(last)
  end

  it 'lists all shelters with pending applications' do
    pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = @shelter_2.pets.create(name: 'Alfie', breed: 'Australian Shepard', age: 1, adoptable: true)
    pet_4 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    application = Application.create!(name: 'Natalie', street_address: '1234 Random St', city: 'Englewood', state: 'CO', zip_code: '80205')

    application.pets << pet_1
    application.pets << pet_3

    visit '/admin/shelters'

    within('#pending_shelters') do
      expect(page).to have_content('No shelters with pending applications')
    end

    application.submit('Pending shelter test')

    visit '/admin/shelters'

    within('#pending_shelters') do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
      expect(page).to_not have_content(@shelter_3.name)
    end
  end

  it 'shelters with pending applications are in alphabetical order' do
    pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = @shelter_2.pets.create(name: 'Alfie', breed: 'Australian Shepard', age: 1, adoptable: true)
    pet_4 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    application = Application.create!(name: 'Natalie', street_address: '1234 Random St', city: 'Englewood', state: 'CO', zip_code: '80205')

    application.pets << pet_3
    application.pets << pet_4
    application.submit('Pending shelter test')

    visit '/admin/shelters'

    first = find("#pending_shelter-#{@shelter_3.id}")
    second = find("#pending_shelter-#{@shelter_2.id}")

    expect(first).to appear_before(second)
  end
end
