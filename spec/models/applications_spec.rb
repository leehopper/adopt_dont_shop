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
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values([:in_progress, :pending, :accepted, :rejected]) }
  end

  before(:each) do
    @application = Application.create!(name: 'Natalie', street_address: '1234 Random St', city: 'Englewood', state: 'CO', zip_code: '80205')
    @shelter = Shelter.create!(name: 'Englewood Shelter', city: 'Englewood CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(name: 'Alfie', age: 1, breed: 'Australian Shepard', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = Pet.create!(name: 'Hazel', age: 2, breed: 'Nova Scotia Duck Tolling Retriever', adoptable: true, shelter_id: @shelter.id)
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
    describe '#submit' do
      it 'updates application to pending with new description' do
        expect(@application.description).to eq('none')
        expect(@application.status).to eq('in_progress')

        @application.submit('I have a yard')

        expect(@application.description).to eq('I have a yard')
        expect(@application.status).to eq('pending')
      end
    end

    describe '#add_pet' do
      it 'adds a pet to the application' do

        expect(@application.pets.count).to eq(0)

        @application.add_pet(@pet_1.id)

        expect(@application.pets).to eq([@pet_1])
      end
    end

    describe '#approved_pets' do
      it 'returns list of applications approved pets' do
        @application.add_pet(@pet_1.id)
        pet_application = PetApplication.locate_record(@application.id, @pet_1.id)
        pet_application.approve

        expect(pet_application.approval_status).to eq('approved')
        expect(@application.approved_pets).to eq([@pet_1])
      end
    end

    describe '#denied_pets' do
      it 'returns list of applications denied pets' do
        @application.add_pet(@pet_1.id)
        pet_application = PetApplication.locate_record(@application.id, @pet_1.id)
        pet_application.deny

        expect(pet_application.approval_status).to eq('denied')
        expect(@application.denied_pets).to eq([@pet_1])
      end
    end

    describe '#pending_pets' do
      it 'returns list of applications pending pets' do
        @application.add_pet(@pet_1.id)
        @application.add_pet(@pet_2.id)
        pet_application_1 = PetApplication.locate_record(@application.id, @pet_1.id)
        pet_application_2 = PetApplication.locate_record(@application.id, @pet_2.id)
        pet_application_1.deny

        expect(pet_application_2.approval_status).to eq('pending')
        expect(@application.pending_pets).to eq([@pet_2])
      end
    end

    describe '#approve?' do
      it 'does not change status if some pets still pending' do
        @application.add_pet(@pet_1.id)
        @application.add_pet(@pet_2.id)
        @application.submit('I love dogs')
        pet_application_1 = PetApplication.locate_record(@application.id, @pet_1.id)
        pet_application_2 = PetApplication.locate_record(@application.id, @pet_2.id)
        pet_application_1.deny

        @application.approve?

        expect(@application.status).to eq('pending')
      end

      it 'denies the application if any pets denied' do
        @application.add_pet(@pet_1.id)
        @application.add_pet(@pet_2.id)
        pet_application_1 = PetApplication.locate_record(@application.id, @pet_1.id)
        pet_application_2 = PetApplication.locate_record(@application.id, @pet_2.id)
        pet_application_1.deny
        pet_application_2.approve

        @application.approve?

        expect(@application.status).to eq('rejected')
      end

      it 'accepts the application if all pets approved' do
        @application.add_pet(@pet_1.id)
        @application.add_pet(@pet_2.id)
        pet_application_1 = PetApplication.locate_record(@application.id, @pet_1.id)
        pet_application_2 = PetApplication.locate_record(@application.id, @pet_2.id)
        pet_application_1.approve
        pet_application_2.approve

        @application.approve?

        expect(@application.status).to eq('accepted')
      end
    end
  end
end
