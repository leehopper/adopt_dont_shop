require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to :pet }
    it { should belong_to :application }
  end

  describe 'enum' do
    it { should define_enum_for(:approval_status).with_values([:pending, :approved, :denied]) }
  end

  before(:each) do
    @application = Application.create!(name: 'Natalie', street_address: '1234 Random St', city: 'Englewood', state: 'CO', zip_code: '80205')
    @shelter = Shelter.create!(name: 'Englewood Shelter', city: 'Englewood CO', foster_program: false, rank: 9)
    @pet_1 = @application.pets.create!(name: 'Alfie', age: 1, breed: 'Australian Shepard', adoptable: true, shelter_id: @shelter.id)
  end

  describe 'class methods' do
    describe '#locate_record' do
      it 'returns PetApplication record given pet and app id' do
        record = PetApplication.locate_record(@application.id, @pet_1.id)

        expect(record.pet_id).to eq(@pet_1.id)
        expect(record.application_id).to eq(@application.id)
      end
    end
  end

  describe 'instance methods' do
    describe '#approve' do
      it 'returns PetApplication instance with status approved' do
        pet_application = PetApplication.locate_record(@application.id, @pet_1.id)

        expect(pet_application.approval_status).to eq('pending')

        pet_application.approve

        expect(pet_application.approval_status).to eq('approved')
      end
    end
  end
end
