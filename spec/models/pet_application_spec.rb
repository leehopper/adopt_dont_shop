require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to :pet }
    it { should belong_to :application }
  end

  describe 'enum' do
    it { should define_enum_for(:approval_status).with_values([:pending, :approved, :denied]) }
  end
end
