class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  enum approval_status: [ :pending, :approved, :denied ]
end
