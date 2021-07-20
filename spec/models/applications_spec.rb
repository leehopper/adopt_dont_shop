require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
    it { should have_many(:shelters).through(:pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values([:in_progress, :pending, :accepted, :rejected]) }
  end

  before(:each) do
    @application = Application.create!(name: 'Natalie', street_address: '1234 Random St', city: 'Englewood', state: 'CO', zip_code: '80205')
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
    describe '#submit' do
      it 'updates application to pending with new description' do
        expect(@application.description).to eq('')
        expect(@application.status).to eq('in_progress')

        @application.submit('I have a yard')

        expect(@application.description).to eq('I have a yard')
        expect(@application.status).to eq('pending')
      end
    end

    describe '#add_pet' do
      it 'adds a pet to the application' do
        shelter = Shelter.create!(name: 'Englewood Shelter', city: 'Englewood CO', foster_program: false, rank: 9)
        pet_1 = Pet.create!(name: 'Alfie', age: 1, breed: 'Australian Shepard', adoptable: true, shelter_id: shelter.id)

        expect(@application.pets.count).to eq(0)

        @application.add_pet(pet_1.id)

        expect(@application.pets).to eq([pet_1])
      end
    end
  end
end
