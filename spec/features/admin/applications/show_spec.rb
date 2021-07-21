require 'rails_helper'

RSpec.describe 'the admin application' do
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
    @application = Application.create!(name: 'Natalie',
                                      street_address: '1234 Random St',
                                      city: 'Englewood',
                                      state: 'CO',
                                      zip_code: '80205',
                                      description: 'Because I am the best',
                                      status: 'pending')
    @application.pets << @pet_1
    @application.pets << @pet_2
  end

  it 'displays attributes' do
    visit "/admin/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.street_address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.zip_code)
    expect(page).to have_content(@application.status)
    expect(page).to have_content(@application.description)
  end

  it 'displays all pets for the application' do
    visit "/admin/applications/#{@application.id}"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to_not have_content(@pet_3.name)
  end

  it 'displays approve and deny buttons for each pet' do
    visit "/admin/applications/#{@application.id}"

    within("#pet-#{@pet_1.id}") do
      expect(page).to have_selector(:link_or_button, "Approve #{@pet_1.name}")
      expect(page).to have_selector(:link_or_button, "Deny #{@pet_1.name}")
    end

    within("#pet-#{@pet_2.id}") do
      expect(page).to have_selector(:link_or_button, "Approve #{@pet_2.name}")
      expect(page).to have_selector(:link_or_button, "Deny #{@pet_2.name}")
    end
  end

  it 'approve pet removes button from page and indicates approval' do
    visit "/admin/applications/#{@application.id}"

    within("#pet-#{@pet_1.id}") do
      click_button "Approve #{@pet_1.name}"
    end

    within("#pet-#{@pet_1.id}") do
      expect(page).to_not have_selector(:link_or_button, "Approve #{@pet_1.name}")
      expect(page).to_not have_selector(:link_or_button, "Deny #{@pet_1.name}")
      expect(page).to have_content("#{@pet_1.name} - APPROVED")
    end
  end

  it 'deny pet removes both button from page and indicates approval' do
    visit "/admin/applications/#{@application.id}"

    within("#pet-#{@pet_1.id}") do
      click_button "Deny #{@pet_1.name}"
    end

    within("#pet-#{@pet_1.id}") do
      expect(page).to_not have_selector(:link_or_button, "Approve #{@pet_1.name}")
      expect(page).to_not have_selector(:link_or_button, "Deny #{@pet_1.name}")
      expect(page).to have_content("#{@pet_1.name} - DENIED")
    end
  end

  it 'approving or dissaproving a pet on one application doesn not impact another' do
    application_2 = Application.create!(name: 'Natalie', street_address: '1234 Random St', city: 'Englewood', state: 'CO', zip_code: '80205', description: 'Because I am the best', status: 'pending')

    application_2.pets << @pet_1
    application_2.pets << @pet_2

    visit "/admin/applications/#{@application.id}"

    within("#pet-#{@pet_1.id}") do
      click_button "Deny #{@pet_1.name}"
    end

    visit "/admin/applications/#{application_2.id}"

    within("#pet-#{@pet_1.id}") do
      expect(page).to have_selector(:link_or_button, "Approve #{@pet_1.name}")
      expect(page).to have_selector(:link_or_button, "Deny #{@pet_1.name}")
    end

    within("#pet-#{@pet_2.id}") do
      expect(page).to have_selector(:link_or_button, "Approve #{@pet_2.name}")
      expect(page).to have_selector(:link_or_button, "Deny #{@pet_2.name}")
    end
  end
end
