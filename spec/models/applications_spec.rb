require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should define_enum_for(:status).with_values([:in_progress, :pending, :accepted, :rejected]) }
  end
end
